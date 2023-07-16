#!/usr/bin/env bash

EXTENSIONS=(
  "chakrounanas.turbo-console-log" \
  "danielsanmedium.dscodegpt" \
  "dbaeumer.vscode-eslint" \
  "denoland.vscode-deno" \
  "EditorConfig.EditorConfig" \
  "eg2.vscode-npm-script" \
  "xdebug.php-debug" \
  "zobo.php-intellisense" \
  "geddski.macros" \
  "GitHub.remotehub" \
  "GitHub.vscode-github-actions" \
  "ikappas.phpcs" \
  "mikestead.dotenv" \
  "ms-python.python" \
  "ms-python.vscode-pylance" \
  "ms-toolsai.jupyter" \
  "ms-vscode-remote.remote-containers" \
  "ms-vsliveshare.vsliveshare" \
  "oderwat.indent-rainbow" \
  "PKief.material-icon-theme" \
  "redhat.vscode-yaml" \
  "waderyan.gitblame" \
  "yatki.vscode-surround"
)

for VARIANT in "code"
do
  if hash $VARIANT 2>/dev/null; then
    echo "Installing extensions for $VARIANT"
    for EXTENSION in ${EXTENSIONS[@]}
    do
      $VARIANT --install-extension $EXTENSION
    done
  fi
done

CODETERM_EXTENSIONS=(
  "foam.foam-vscode" \
  "mushan.vscode-paste-image" \
  "PKief.material-icon-theme"
)

for VARIANT in "code-insiders"
do
  if hash $VARIANT 2>/dev/null; then
    echo "Installing extensions for $VARIANT"
    for CODETERM_EXTENSION in ${CODETERM_EXTENSIONS[@]}
    do
      $VARIANT --install-extension $CODETERM_EXTENSION
    done
  fi
done