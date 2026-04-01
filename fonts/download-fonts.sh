#!/bin/bash
# Script to download additional fonts and commit them to the repository

set -e

FONT_DIR="$(dirname "$0")"

echo "Downloading DejaVu fonts..."
cd "$FONT_DIR"
mkdir -p dejavu
cd dejavu
curl -L "https://downloads.sourceforge.net/project/dejavu/dejavu/2.37/dejavu-fonts-ttf-2.37.tar.bz2" -o dejavu.tar.bz2
tar xjf dejavu.tar.bz2
mv dejavu-fonts-ttf-2.37/ttf/*.ttf .
rm -rf dejavu-fonts-ttf-2.37 dejavu.tar.bz2
echo "✓ DejaVu fonts downloaded"

echo ""
echo "Downloading Ubuntu fonts..."
cd "$FONT_DIR"
mkdir -p ubuntu
cd ubuntu
curl -L "https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-0.83.zip" -o ubuntu-fonts.zip
unzip -q ubuntu-fonts.zip
mv ubuntu-font-family-0.83/*.ttf .
rm -rf ubuntu-font-family-0.83 ubuntu-fonts.zip
echo "✓ Ubuntu fonts downloaded"

echo ""
echo "All fonts downloaded successfully!"
echo "You can now commit them with: git add fonts/ && git commit -m 'Add DejaVu and Ubuntu fonts'"
