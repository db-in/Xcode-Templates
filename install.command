#/bin/bash
echo ""
echo "----------------------------------------"
echo "   Installing Advanced Xcode Toolset    "
echo "----------------------------------------"
echo ""
echo "---> Pre-installation step (authorization)"

BASEDIR="$( dirname "$0" )"
cd "$BASEDIR"
sudo --validate

echo "---> Installing templates"

TEMPLATES_PATH="/Library/Developer/Xcode/Templates"
sudo mkdir -p "$TEMPLATES_PATH"
sudo rm -rf "$TEMPLATES_PATH/File Templates/Source"
sudo rm -rf "$TEMPLATES_PATH/Project Templates/Application"
sudo rm -rf "$TEMPLATES_PATH/Project Templates/Test"
sudo cp -rf "Templates/File Templates" "$TEMPLATES_PATH"
sudo cp -rf "Templates/Project Templates" "$TEMPLATES_PATH"

echo "---> Installing user data"

USERDATA_PATH="$HOME/Library/Developer/Xcode/UserData/"
sudo mkdir -p "$USERDATA_PATH"
sudo cp -rf "UserData/CodeSnippets" "$USERDATA_PATH"
sudo cp -rf "UserData/FontAndColorThemes" "$USERDATA_PATH"
sudo cp -rf "UserData/KeyBindings" "$USERDATA_PATH"

echo "---> Installing SwiftLint"

FWK_PATH="/Library/Frameworks"
BIN_PATH="/usr/local/bin"
sudo mkdir -p "$FWK_PATH" "$BIN_PATH"
sudo rm -rf "$FWK_PATH/SwiftLintFramework.framework"
sudo rm -rf "$BIN_PATH/swiftlint"
sudo cp -rf "Tools/SwiftLint/SwiftLintFramework.framework" "$FWK_PATH"
sudo cp -rf "Tools/SwiftLint/swiftlint" "$BIN_PATH"

echo "---> Installing Jazzy tool (requires internet)"

sudo gem install jazzy

echo "---> Final Report"
echo "[ √ ] Xcode Template installed at $TEMPLATES_PATH"
echo "[ √ ] Xcode CodeSnippets installed at $USERDATA_PATH"
echo "[ √ ] Xcode FontAndColorThemes installed at $USERDATA_PATH"
echo "[ √ ] Xcode KeyBindings installed at $USERDATA_PATH"
echo "[ √ ] SwiftLint installed at $FWK_PATH and $BIN_PATH"
echo "[ √ ] Jazzy tool was installed using gem"
echo ""
echo "----------------------------------------"
echo "     Toolset Installed Successfully     "
echo "----------------------------------------"
echo ""
