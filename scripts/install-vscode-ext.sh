#!/usr/bin/env bash

EXTENSIONS=(
  "chakrounanas.turbo-console-log" \
  "dbaeumer.vscode-eslint" \
  "denoland.vscode-deno" \
  "EditorConfig.EditorConfig" \
  "eg2.vscode-npm-script" \
  "felixfbecker.php-debug" \
  "felixfbecker.php-intellisense" \
  "geddski.macros" \
  "GitHub.remotehub" \
  "ikappas.phpcs" \
  "mikestead.dotenv" \
  "ms-python.python" \
  "ms-python.vscode-pylance" \
  "ms-toolsai.jupyter" \
  "ms-vscode-remote.remote-containers" \
  "ms-vsliveshare.vsliveshare" \
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
