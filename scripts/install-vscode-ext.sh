EXTENSIONS=(
  "EditorConfig.EditorConfig" \
  "HvyIndustries.crane" \
  "PeterJausovec.vscode-docker" \
  "RoscoP.ActiveFileInStatusBar" \
  "christian-kohler.npm-intellisense" \
  "christian-kohler.path-intellisense" \
  "dbaeumer.vscode-eslint" \
  "devtanc.tab-hero" \
  "donjayamanne.githistory" \
  "eg2.vscode-npm-script" \
  "felixfbecker.php-debug" \
  "felixfbecker.php-intellisense" \
  "formulahendry.auto-close-tag" \
  "formulahendry.code-runner" \
  "geddski.macros" \
  "ikappas.phpcs" \
  "mikestead.dotenv" \
  "ms-vscode.typescript-javascript-grammar" \
  "msjsdiag.debugger-for-chrome" \
  "pmneo.tsimporter" \
  "robertohuertasm.vscode-icons" \
  "spywhere.guides" \
  "whatwedo.twig"
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
