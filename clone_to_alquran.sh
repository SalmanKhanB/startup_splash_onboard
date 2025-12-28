#!/bin/bash

# Script to clone startup_repo to alquran project
# Author: AI Assistant
# Date: 2025-12-29

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
SOURCE_DIR="/Users/mc/Development/projectsEzaa/startup_repo"
TARGET_DIR="/Users/mc/Development/projectsEzaa/alquran"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Cloning startup_repo to alquran${NC}"
echo -e "${BLUE}========================================${NC}\n"

# Step 1: Create target directory
echo -e "${YELLOW}[1/8]${NC} Creating target directory..."
mkdir -p "$TARGET_DIR"
echo -e "${GREEN}✓ Directory created${NC}\n"

# Step 2: Copy project files (excluding build artifacts, git, and dependencies)
echo -e "${YELLOW}[2/8]${NC} Copying project files..."
rsync -av \
  --exclude='.git/' \
  --exclude='.dart_tool/' \
  --exclude='build/' \
  --exclude='.fvm/' \
  --exclude='ios/Pods/' \
  --exclude='ios/.symlinks/' \
  --exclude='android/.gradle/' \
  --exclude='android/app/build/' \
  --exclude='android/build/' \
  --exclude='.flutter-plugins' \
  --exclude='.flutter-plugins-dependencies' \
  --exclude='.metadata' \
  --exclude='*.log' \
  --exclude='.DS_Store' \
  --exclude='clone_to_alquran.sh' \
  "$SOURCE_DIR/" "$TARGET_DIR/"

echo -e "${GREEN}✓ Files copied${NC}\n"

# Step 3: Update pubspec.yaml
echo -e "${YELLOW}[3/8]${NC} Updating pubspec.yaml..."
sed -i '' 's/name: startup_repo/name: alquran/g' "$TARGET_DIR/pubspec.yaml"
sed -i '' 's/description: "A new Flutter project."/description: "Al-Quran application."/g' "$TARGET_DIR/pubspec.yaml"
echo -e "${GREEN}✓ pubspec.yaml updated${NC}\n"

# Step 4: Update .env file
echo -e "${YELLOW}[4/8]${NC} Updating .env file..."
cat > "$TARGET_DIR/.env" << 'EOL'
# App name
APP_NAME=Al-Quran

# Android Configuration
BUNDLE_ID_ANDROID=com.example.alquran
ANDROID_VERSION_CODE=1
ANDROID_VERSION_NAME=1.0
MIN_SDK_VERSION=24
TARGET_SDK_VERSION=34

# Keystore details for Android
KEYSTORE_PATH=keystore.jks
KEYSTORE_ALIAS=upload
KEYSTORE_PASSWORD=upload
KEY_PASSWORD=upload
EOL
echo -e "${GREEN}✓ .env file updated${NC}\n"

# Step 5: Update Android namespace
echo -e "${YELLOW}[5/8]${NC} Updating Android configuration..."
sed -i '' 's/namespace = "com.example.startup_repo"/namespace = "com.example.alquran"/g' "$TARGET_DIR/android/app/build.gradle.kts"
echo -e "${GREEN}✓ Android configuration updated${NC}\n"

# Step 6: Update Android package structure
echo -e "${YELLOW}[6/8]${NC} Updating Android package structure..."
OLD_PACKAGE_PATH="$TARGET_DIR/android/app/src/main/kotlin/com/example/startup_repo"
NEW_PACKAGE_PATH="$TARGET_DIR/android/app/src/main/kotlin/com/example/alquran"

if [ -d "$OLD_PACKAGE_PATH" ]; then
    mkdir -p "$TARGET_DIR/android/app/src/main/kotlin/com/example"
    mv "$OLD_PACKAGE_PATH" "$NEW_PACKAGE_PATH" 2>/dev/null || true
    
    # Update MainActivity.kt package name
    if [ -f "$NEW_PACKAGE_PATH/MainActivity.kt" ]; then
        sed -i '' 's/package com.example.startup_repo/package com.example.alquran/g' "$NEW_PACKAGE_PATH/MainActivity.kt"
    fi
    
    echo -e "${GREEN}✓ Android package structure updated${NC}\n"
else
    echo -e "${YELLOW}⚠ Android Kotlin files not found, skipping...${NC}\n"
fi

# Step 7: Update iOS bundle identifier
echo -e "${YELLOW}[7/8]${NC} Updating iOS configuration..."
if [ -f "$TARGET_DIR/ios/Runner.xcodeproj/project.pbxproj" ]; then
    sed -i '' 's/com.example.startupRepo/com.example.alquran/g' "$TARGET_DIR/ios/Runner.xcodeproj/project.pbxproj"
    echo -e "${GREEN}✓ iOS configuration updated${NC}\n"
else
    echo -e "${YELLOW}⚠ iOS project file not found, skipping...${NC}\n"
fi

# Step 8: Initialize new Git repository
echo -e "${YELLOW}[8/8]${NC} Initializing new Git repository..."
cd "$TARGET_DIR"
git init
git add .
git commit -m "Initial commit - Cloned from startup_repo"
echo -e "${GREEN}✓ Git repository initialized${NC}\n"

# Final summary
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}✓ Project cloned successfully!${NC}"
echo -e "${BLUE}========================================${NC}\n"

echo -e "${BLUE}Next steps:${NC}"
echo -e "1. cd $TARGET_DIR"
echo -e "2. Run: flutter pub get"
echo -e "3. Run: flutter pub run flutter_launcher_icons"
echo -e "4. Test the app: flutter run"
echo -e "5. Add remote repository: git remote add origin <your-new-repo-url>"
echo -e "6. Push to remote: git push -u origin main\n"

echo -e "${YELLOW}Note:${NC} Remember to update your app icon in assets/images/logo.png"
echo -e "${YELLOW}Note:${NC} Update your app name and branding in the lib/ directory as needed\n"
