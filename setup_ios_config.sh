#!/bin/bash

# Script to set up iOS configuration for Flutter app
# This script automates the process of:
# 1. Creating Environment.xcconfig with app configuration
# 2. Updating Debug.xcconfig and Release.xcconfig to include Environment.xcconfig
# 3. Ensuring project.pbxproj uses the variables correctly

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Default values
APP_NAME=""
APP_VERSION=""
BUILD_NUMBER=""
BUNDLE_ID=""

# Function to prompt for input with default value
prompt_with_default() {
  local prompt="$1"
  local default="$2"
  local var_name="$3"
  local user_input

  if [ -z "${!var_name}" ]; then
    # Only prompt if the variable is not already set via command line
    echo -en "${prompt} [${YELLOW}${default}${NC}]: "
    read user_input
    if [ -z "$user_input" ]; then
      eval "$var_name=\"$default\""
    else
      eval "$var_name=\"$user_input\""
    fi
  fi
}

# Function to display script usage
show_usage() {
  echo -e "Usage: $0 [options]"
  echo -e "Options:"
  echo -e "  -n, --name NAME         Set app name (default: $APP_NAME)"
  echo -e "  -v, --version VERSION   Set app version (default: $APP_VERSION)"
  echo -e "  -b, --build BUILD       Set build number (default: $BUILD_NUMBER)"
  echo -e "  -i, --bundle-id ID      Set bundle identifier (default: $BUNDLE_ID)"
  echo -e "  -h, --help              Show this help message"
  exit 1
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -n|--name)
      APP_NAME="$2"
      shift 2
      ;;
    -v|--version)
      APP_VERSION="$2"
      shift 2
      ;;
    -b|--build)
      BUILD_NUMBER="$2"
      shift 2
      ;;
    -i|--bundle-id)
      BUNDLE_ID="$2"
      shift 2
      ;;
    -h|--help)
      show_usage
      ;;
    *)
      echo -e "${RED}Unknown option: $1${NC}"
      show_usage
      ;;
  esac
done

# Check if we're in the Flutter project root
if [ ! -d "ios" ]; then
  echo -e "${RED}Error: 'ios' directory not found. Please run this script from your Flutter project root.${NC}"
  exit 1
fi

# Prompt for values if not provided via command line
echo -e "${GREEN}Flutter iOS Configuration Setup${NC}"
echo -e "${YELLOW}Please provide the following information:${NC}"

# Default values for prompts
DEFAULT_APP_NAME="Ajar"
DEFAULT_APP_VERSION="1.0.0"
DEFAULT_BUILD_NUMBER="1"
DEFAULT_BUNDLE_ID="com.dcodax.ajar.app"

# Prompt for each value
prompt_with_default "App Name" "$DEFAULT_APP_NAME" "APP_NAME"
prompt_with_default "App Version" "$DEFAULT_APP_VERSION" "APP_VERSION"
prompt_with_default "Build Number" "$DEFAULT_BUILD_NUMBER" "BUILD_NUMBER"
prompt_with_default "Bundle ID" "$DEFAULT_BUNDLE_ID" "BUNDLE_ID"

echo -e "\n${GREEN}Using the following configuration:${NC}"
echo -e "  App Name: ${YELLOW}$APP_NAME${NC}"
echo -e "  App Version: ${YELLOW}$APP_VERSION${NC}"
echo -e "  Build Number: ${YELLOW}$BUILD_NUMBER${NC}"
echo -e "  Bundle ID: ${YELLOW}$BUNDLE_ID${NC}"
echo -e ""

# Create ios/Flutter directory if it doesn't exist
if [ ! -d "ios/Flutter" ]; then
  echo -e "${YELLOW}Creating ios/Flutter directory...${NC}"
  mkdir -p ios/Flutter
fi

# Create Environment.xcconfig
echo -e "${GREEN}Creating Environment.xcconfig...${NC}"
cat > ios/Flutter/Environment.xcconfig << EOF
APP_NAME = $APP_NAME
APP_VERSION = $APP_VERSION
BUILD_NUMBER = $BUILD_NUMBER
BUNDLE_ID = $BUNDLE_ID
EOF
echo -e "${GREEN}✓ Created Environment.xcconfig${NC}"

# Update Debug.xcconfig
echo -e "${GREEN}Updating Debug.xcconfig...${NC}"
if [ -f "ios/Flutter/Debug.xcconfig" ]; then
  # Check if Environment.xcconfig is already included
  if grep -q "#include \"Environment.xcconfig\"" ios/Flutter/Debug.xcconfig; then
    echo -e "${YELLOW}Environment.xcconfig already included in Debug.xcconfig${NC}"
  else
    # Add include for Environment.xcconfig and variable definitions
    cat > ios/Flutter/Debug.xcconfig.new << EOF
#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.debug.xcconfig"
#include "Generated.xcconfig"
#include "Environment.xcconfig"

MY_APP_NAME = \${APP_NAME}
MY_MARKETING_VERSION = \${APP_VERSION}
MY_CURRENT_PROJECT_VERSION = \${BUILD_NUMBER}
MY_BUNDLE_ID = \${BUNDLE_ID}
EOF
    mv ios/Flutter/Debug.xcconfig.new ios/Flutter/Debug.xcconfig
    echo -e "${GREEN}✓ Updated Debug.xcconfig${NC}"
  fi
else
  # Create Debug.xcconfig if it doesn't exist
  cat > ios/Flutter/Debug.xcconfig << EOF
#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.debug.xcconfig"
#include "Generated.xcconfig"
#include "Environment.xcconfig"

MY_APP_NAME = \${APP_NAME}
MY_MARKETING_VERSION = \${APP_VERSION}
MY_CURRENT_PROJECT_VERSION = \${BUILD_NUMBER}
MY_BUNDLE_ID = \${BUNDLE_ID}
EOF
  echo -e "${GREEN}✓ Created Debug.xcconfig${NC}"
fi

# Update Release.xcconfig
echo -e "${GREEN}Updating Release.xcconfig...${NC}"
if [ -f "ios/Flutter/Release.xcconfig" ]; then
  # Check if Environment.xcconfig is already included
  if grep -q "#include \"Environment.xcconfig\"" ios/Flutter/Release.xcconfig; then
    echo -e "${YELLOW}Environment.xcconfig already included in Release.xcconfig${NC}"
  else
    # Add include for Environment.xcconfig and variable definitions
    cat > ios/Flutter/Release.xcconfig.new << EOF
#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.release.xcconfig"
#include "Generated.xcconfig"
#include "Environment.xcconfig"

MY_APP_NAME = \${APP_NAME}
MY_MARKETING_VERSION = \${APP_VERSION}
MY_CURRENT_PROJECT_VERSION = \${BUILD_NUMBER}
MY_BUNDLE_ID = \${BUNDLE_ID}
EOF
    mv ios/Flutter/Release.xcconfig.new ios/Flutter/Release.xcconfig
    echo -e "${GREEN}✓ Updated Release.xcconfig${NC}"
  fi
else
  # Create Release.xcconfig if it doesn't exist
  cat > ios/Flutter/Release.xcconfig << EOF
#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.release.xcconfig"
#include "Generated.xcconfig"
#include "Environment.xcconfig"

MY_APP_NAME = \${APP_NAME}
MY_MARKETING_VERSION = \${APP_VERSION}
MY_CURRENT_PROJECT_VERSION = \${BUILD_NUMBER}
MY_BUNDLE_ID = \${BUNDLE_ID}
EOF
  echo -e "${GREEN}✓ Created Release.xcconfig${NC}"
fi

# Update project.pbxproj to use the variables
echo -e "${GREEN}Updating project.pbxproj...${NC}"
PROJECT_FILE="ios/Runner.xcodeproj/project.pbxproj"

if [ -f "$PROJECT_FILE" ]; then
  # Create a backup
  cp "$PROJECT_FILE" "$PROJECT_FILE.bak"

  # Update the build settings to use our variables
  sed -i '' 's/CURRENT_PROJECT_VERSION = [^;]*;/CURRENT_PROJECT_VERSION = "${MY_CURRENT_PROJECT_VERSION}";/g' "$PROJECT_FILE"
  sed -i '' 's/MARKETING_VERSION = [^;]*;/MARKETING_VERSION = "${MY_MARKETING_VERSION}";/g' "$PROJECT_FILE"

  # Only update PRODUCT_BUNDLE_IDENTIFIER for the main app target, not for RunnerTests
  # This is more complex - we need to find lines with PRODUCT_BUNDLE_IDENTIFIER that don't contain RunnerTests
  # Using awk for more precise pattern matching
  awk '
  {
    if ($0 ~ /PRODUCT_BUNDLE_IDENTIFIER = [^;]*;/ && $0 !~ /RunnerTests/) {
      # Replace the line with our variable
      print "					PRODUCT_BUNDLE_IDENTIFIER = \"${MY_BUNDLE_ID}\";"
    } else {
      # Print the line unchanged
      print $0
    }
  }
  ' "$PROJECT_FILE" > "$PROJECT_FILE.tmp" && mv "$PROJECT_FILE.tmp" "$PROJECT_FILE"

  # Add CFBundleDisplayName if not present
  if ! grep -q "INFOPLIST_KEY_CFBundleDisplayName" "$PROJECT_FILE"; then
    sed -i '' '/INFOPLIST_FILE = Runner\/Info.plist;/a\\
					INFOPLIST_KEY_CFBundleDisplayName = "${MY_APP_NAME}";' "$PROJECT_FILE"
  else
    sed -i '' 's/INFOPLIST_KEY_CFBundleDisplayName = [^;]*;/INFOPLIST_KEY_CFBundleDisplayName = "${MY_APP_NAME}";/g' "$PROJECT_FILE"
  fi

  echo -e "${GREEN}✓ Updated project.pbxproj${NC}"
else
  echo -e "${RED}Error: project.pbxproj not found at $PROJECT_FILE${NC}"
  exit 1
fi

# Update Info.plist to use the variables
echo -e "${GREEN}Updating Info.plist...${NC}"
INFO_PLIST="ios/Runner/Info.plist"

if [ -f "$INFO_PLIST" ]; then
  # Create a backup
  cp "$INFO_PLIST" "$INFO_PLIST.bak"

  # Check if CFBundleDisplayName exists
  if grep -q "<key>CFBundleDisplayName</key>" "$INFO_PLIST"; then
    # Update existing CFBundleDisplayName
    sed -i '' 's/<key>CFBundleDisplayName<\/key>[ \t]*\n[ \t]*<string>[^<]*<\/string>/<key>CFBundleDisplayName<\/key>\
			<string>${MY_APP_NAME}<\/string>/g' "$INFO_PLIST"
  else
    # Add CFBundleDisplayName if it doesn't exist
    sed -i '' '/<key>CFBundleName<\/key>/i\\
		<key>CFBundleDisplayName</key>\\
		<string>${MY_APP_NAME}</string>\\
' "$INFO_PLIST"
  fi

  # Update CFBundleName
  sed -i '' 's/<key>CFBundleName<\/key>[ \t]*\n[ \t]*<string>[^<]*<\/string>/<key>CFBundleName<\/key>\
			<string>${MY_APP_NAME}<\/string>/g' "$INFO_PLIST"

  # Make sure CFBundleShortVersionString uses MARKETING_VERSION
  if grep -q "<key>CFBundleShortVersionString</key>" "$INFO_PLIST"; then
    sed -i '' 's/<key>CFBundleShortVersionString<\/key>[ \t]*\n[ \t]*<string>[^<]*<\/string>/<key>CFBundleShortVersionString<\/key>\
			<string>$(MARKETING_VERSION)<\/string>/g' "$INFO_PLIST"
  fi

  # Make sure CFBundleVersion uses CURRENT_PROJECT_VERSION
  if grep -q "<key>CFBundleVersion</key>" "$INFO_PLIST"; then
    sed -i '' 's/<key>CFBundleVersion<\/key>[ \t]*\n[ \t]*<string>[^<]*<\/string>/<key>CFBundleVersion<\/key>\
			<string>$(CURRENT_PROJECT_VERSION)<\/string>/g' "$INFO_PLIST"
  fi

  # Make sure CFBundleIdentifier uses PRODUCT_BUNDLE_IDENTIFIER
  if grep -q "<key>CFBundleIdentifier</key>" "$INFO_PLIST"; then
    sed -i '' 's/<key>CFBundleIdentifier<\/key>[ \t]*\n[ \t]*<string>[^<]*<\/string>/<key>CFBundleIdentifier<\/key>\
			<string>$(PRODUCT_BUNDLE_IDENTIFIER)<\/string>/g' "$INFO_PLIST"
  fi

  echo -e "${GREEN}✓ Updated Info.plist${NC}"
else
  echo -e "${RED}Error: Info.plist not found at $INFO_PLIST${NC}"
  exit 1
fi

echo -e "${GREEN}Configuration setup complete!${NC}"
echo -e "${YELLOW}You can now build your app with the following configuration:${NC}"
echo -e "  App Name: ${GREEN}$APP_NAME${NC}"
echo -e "  App Version: ${GREEN}$APP_VERSION${NC}"
echo -e "  Build Number: ${GREEN}$BUILD_NUMBER${NC}"
echo -e "  Bundle ID: ${GREEN}$BUNDLE_ID${NC}"
echo -e "\nTo change these values in the future, either:"
echo -e "1. Edit ios/Flutter/Environment.xcconfig directly"
echo -e "2. Run this script again with different parameters"
