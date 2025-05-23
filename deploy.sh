#!/bin/bash

# Exit on any error
set -e

# Define variables
BUILD_DIR="/home/ubuntu/deploy-artifacts1/builds/latest"
DEPLOY_DIR="/home/ubuntu/deploy-artifacts1/releases"
SYMLINK_PATH="/home/ubuntu/deploy-artifacts1/current"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
RELEASE_DIR="$DEPLOY_DIR/release-$TIMESTAMP"

# Release directory
mkdir -p "$RELEASE_DIR"

# Copy new build files into the release directory
cp -r "$BUILD_DIR"/* "$RELEASE_DIR/"

# Update symlink to point to the new release
ln -sfn "$RELEASE_DIR" "$SYMLINK_PATH"

echo "Deployment complete. Symlink updated to: $RELEASE_DIR"
