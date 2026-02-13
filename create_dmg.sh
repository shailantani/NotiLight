#!/bin/bash
set -e

APP_NAME="CameraLight"
APP_BUNDLE="${APP_NAME}.app"
DMG_NAME="${APP_NAME}.dmg"
VOL_NAME="${APP_NAME}"

# Ensure the app exists
if [ ! -d "$APP_BUNDLE" ]; then
    echo "App bundle not found. Building..."
    ./build_app.sh
fi

# Create a temporary directory for the DMG contents
echo "Preparing DMG contents..."
rm -rf dmg_temp
mkdir dmg_temp

# Copy the app to the temporary directory
cp -r "$APP_BUNDLE" dmg_temp/

# Create a symlink to /Applications
ln -s /Applications dmg_temp/Applications

# Create the DMG
echo "Creating DMG..."
rm -f "$DMG_NAME"
hdiutil create -volname "$VOL_NAME" -srcfolder dmg_temp -ov -format UDZO "$DMG_NAME"

# Clean up
rm -rf dmg_temp

echo "DMG created successfully: $DMG_NAME"
