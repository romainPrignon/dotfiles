#!/usr/bin/env bash

EXTENSIONS=(
  "chakrounanas.turbo-console-log" \
  # "christian-kohler.path-intellisense" \
  "dbaeumer.vscode-eslint" \
  "EditorConfig.EditorConfig" \
  "eg2.vscode-npm-script" \
  "felixfbecker.php-debug" \
  "felixfbecker.php-intellisense" \
  # "formulahendry.auto-close-tag" \
  "geddski.macros" \
  "ikappas.phpcs" \
  "mikestead.dotenv" \
  "ms-python.python" \
  # "msjsdiag.debugger-for-chrome" \
  "PKief.material-icon-theme" \
  "redhat.vscode-yaml" \
  "waderyan.gitblame" \
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
