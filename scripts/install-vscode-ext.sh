#!/usr/bin/env bash

EXTENSIONS=(
  "chakrounanas.turbo-console-log" \
  "christian-kohler.path-intellisense" \
  "dbaeumer.vscode-eslint" \
  "devtanc.tab-hero" \
  "eamodio.gitlens" \
  "EditorConfig.EditorConfig" \
  "eg2.vscode-npm-script" \
  "felixfbecker.php-debug" \
  "felixfbecker.php-intellisense" \
  "formulahendry.auto-close-tag" \
  "geddski.macros" \
  "ikappas.phpcs" \
  "mikestead.dotenv" \
  "ms-azuretools.vscode-docker" \
  "ms-python.python" \
  "ms-vscode.typescript-javascript-grammar" \
  "ms-vscode.vscode-typescript-tslint-plugin" \
  "msjsdiag.debugger-for-chrome" \
  "PKief.material-icon-theme" \
  "yatki.vscode-surround"
)

for VARIANT in "code" \
               "code-insiders"
do
  if hash $VARIANT 2>/dev/null; then
    echo "Installing extensions for $VARIANT"
    for EXTENSION in ${EXTENSIONS[@]}
    do
      $VARIANT --install-extension $EXTENSION
    done
  fi
done
