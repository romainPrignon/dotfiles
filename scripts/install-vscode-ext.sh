EXTENSIONS=(
  "EditorConfig.EditorConfig" \
  "dbaeumer.vscode-eslint" \
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
