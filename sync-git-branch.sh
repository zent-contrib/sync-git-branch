#!/bin/sh

set -e

SOURCE_REPO="$1"
SOURCE_BRANCH="$2"
DESTINATION_REPO="$3"
DESTINATION_BRANCH="${4:-$2}"
REPO_DIR="repo"

echo "SOURCE=$SOURCE_REPO:$SOURCE_BRANCH"
echo "DESTINATION=$DESTINATION_REPO:$DESTINATION_BRANCH"

# Only clone the branch we want to sync
git clone --single-branch --branch "$SOURCE_BRANCH" "$SOURCE_REPO" "$REPO_DIR"
cd "$REPO_DIR"
git remote add mirror "$DESTINATION_REPO"
git push mirror "$SOURCE_BRANCH:$DESTINATION_BRANCH"