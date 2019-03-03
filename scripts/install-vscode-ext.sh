#!/usr/bin/env bash

EXTENSIONS=(
  "eg2.tslint" \
  "EditorConfig.EditorConfig" \
  "PeterJausovec.vscode-docker" \
  "christian-kohler.npm-intellisense" \
  "christian-kohler.path-intellisense" \
  "dbaeumer.vscode-eslint" \
  "devtanc.tab-hero" \
  "eg2.vscode-npm-script" \
  "felixfbecker.php-debug" \
  "felixfbecker.php-intellisense" \
  "formulahendry.auto-close-tag" \
  "geddski.macros" \
  "ikappas.phpcs" \
  "mikestead.dotenv" \
  "ms-vscode.typescript-javascript-grammar" \
  "msjsdiag.debugger-for-chrome" \
  "PKief.material-icon-theme" \
  "whatwedo.twig" \
  "yatki.vscode-surround" \
  "kenhowardpdx.vscode-gist" \
  "eamodio.gitlens"
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
