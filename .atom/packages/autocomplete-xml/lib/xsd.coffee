http = require 'http'
https = require 'https'
fs = require 'fs'
path = require 'path'
xsdParser = require './xsdParser'

module.exports =
  types: {}


  ## Clear the data. This is the case of changing the XSD.
  clear: ->
    @types = {}


  ## Load a new XSD.
  load: (xmlPath, xsdUri, complete) ->
    # Get the protocol used to download the file.
    protocol = null
    if xsdUri.substr(0, 7) is "http://"
      protocol = http
    else if xsdUri.substr(0, 8) is "https://"
      protocol = https

    if protocol
      # Download the file
      protocol.get(xsdUri, (res) =>
        body = ''
        res.on 'data', (chunk) ->
          body += chunk;

        # On complete, parse XSD
        res.on 'end', =>
          @parseFromString(body, complete)
      ).on 'error', (e) ->
        console.error e
    else
      # Get the base path. In absolute path nothing, in relative the file dir.
      if xsdUri[0] == '/' or xsdUri.substr(1, 2) == ':\\'
        basePath = ''
      else
        basePath = path.dirname xmlPath

      # Read the file from disk
      fs.readFile path.join(basePath, xsdUri), (err, data) =>
        if err then console.error err else @parseFromString(data, complete)


  ## Parse the the XML
  parseFromString: (data, complete) ->
    @types = xsdParser.types
    xsdParser.parseFromString(data, complete)


  ## Called when suggestion requested. Get all the possible node children.
  getChildren: (xpath) ->
    # If there is no path, we need a root node first!
    if xpath.length == 0
      return (value for name, value of xsdParser.roots)

    # Get the XSD type name from the tag name.
    type = @findTypeFromXPath xpath
    if not type or type.xsdType isnt 'complex'
      return []

    # Create list of suggestions from childrens
    # TODO: Represent groups in autocompletion
    suggestions = []
    for group in type.xsdChildren
      suggestions.push @createChildSuggestion el for el in group.elements

    # Remove undefined elements (e.g.: non-supported yet types).
    suggestions.filter (n) -> n != undefined


  ## Search the type from the XPath
  findTypeFromXPath: (xpath) ->
    type = xsdParser.roots[xpath[0]]
    xpath.shift()  # Remove root node.

    while xpath && xpath.length > 0 && type
      nextTag = xpath.shift()
      nextTypeName = @findTypeFromTag nextTag, type
      type = @types[nextTypeName]

    return type


  ## Search for the XSD type name by using the tag name.
  findTypeFromTag: (tagName, node) ->
    for group in node.xsdChildren
      for el in group.elements
        return el.xsdTypeName if el.tagName == tagName


  ## Create a suggestion object from a child object.
  createChildSuggestion: (child) ->
    # The suggestion is a merge between the general type info and the
    # specific information from the child object.
    childType = @types[child.xsdTypeName]
    sug =
      text: child.tagName + '>'
      displayText: child.tagName
      description: child.description ? childType?.description
      type: childType?.type
      rightLabel: childType?.rightLabel
      leftLabel: childType?.leftLabel


  ## Get the values from a tag.
  getValues: (xpath) ->
    # Get the XSD type name from the tag name.
    type = @findTypeFromXPath xpath
    if not type or type.xsdType isnt 'simple'
      return []

    # Create list of suggestions from childrens
    # TODO: Represent groups in autocompletion
    suggestions = []
    for group in type.xsdChildren
      suggestions.push @createValueSuggestion el for el in group.elements

    # Remove undefined elements (e.g.: non-supported yet types).
    suggestions.filter (n) -> n != undefined

  ## Create a suggestion from the tag values.
  createValueSuggestion: (child) ->
    text: child.tagName
    displayText: child.tagName
    type: 'value'
    rightLabel: 'Value'

  ## Called when suggestion requested for attributes.
  getAttributes: (xpath) ->
    # Get the XSD type name from the tag name.
    type = @findTypeFromXPath xpath
    if not type
      return []

    # Create list of suggestions from attributes
    return (@createAttributeSuggestion attr for attr in type.xsdAttributes)


  ## Create a suggestion from the attribute.
  createAttributeSuggestion: (attr) ->
    displayText: attr.name
    snippet: attr.name + '="${1:' + ((attr.fixed ? attr.default) ? '') + '}"'
    description: attr.description
    type: 'attribute'
    rightLabel: 'Attribute'
    leftLabel: attr.type
