TODO:
reference des elements du system prompt sans les repété

Example of detailed prompt:
"Create a component named {componentName} using {techstack}.
It follows {description of technical capabilities}.
It should {description of functionality}.
Here is the full component code."

### (Additional) Instructions TODO: additional or not !!!
- If the request involves a single unit of code, generate a full implementation.
- If the request involves more than three unit of code, provide only the core logic.

### code style
**1** **use Early Returns**: Use early returns to avoid nested conditions and improve readability.
