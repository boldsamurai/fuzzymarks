#!/bin/bash
set -e

VERSION=$(grep '"version"' manifest.json | head -1 | sed 's/.*: *"\(.*\)".*/\1/')
DIST="dist"
SHARED_FILES="newtab.html newtab.js newtab.css i18n.js browser-polyfill.js fuzzysort.min.js icons"

rm -rf "$DIST"
mkdir -p "$DIST"

# Firefox build
echo "Building Firefox package..."
FIREFOX_DIR=$(mktemp -d)
cp -r $SHARED_FILES "$FIREFOX_DIR/"
cp manifest.json "$FIREFOX_DIR/manifest.json"
(cd "$FIREFOX_DIR" && zip -r "$OLDPWD/$DIST/fuzzymarks-firefox-$VERSION.zip" .)
rm -rf "$FIREFOX_DIR"
echo "  -> $DIST/fuzzymarks-firefox-$VERSION.zip"

# Chrome build
echo "Building Chrome package..."
CHROME_DIR=$(mktemp -d)
cp -r $SHARED_FILES "$CHROME_DIR/"
cp manifest-chrome.json "$CHROME_DIR/manifest.json"
(cd "$CHROME_DIR" && zip -r "$OLDPWD/$DIST/fuzzymarks-chrome-$VERSION.zip" .)
rm -rf "$CHROME_DIR"
echo "  -> $DIST/fuzzymarks-chrome-$VERSION.zip"

echo "Done!"
