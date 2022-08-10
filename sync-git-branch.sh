#!/bin/sh

set -e

SOURCE_REPO="$1"
SOURCE_BRANCH="$2"
DESTINATION_REPO="$3"
DESTINATION_BRANCH="${4:-$2}"

echo "SOURCE=$SOURCE_REPO:$SOURCE_BRANCH"
echo "DESTINATION=$DESTINATION_REPO:$DESTINATION_BRANCH"

git remote add mirror "$DESTINATION_REPO"

# Pull all branches references down locally so subsequent commands can see them
git fetch source '+refs/heads/*:refs/heads/*' --update-head-ok

git push -f mirror "$SOURCE_BRANCH:$DESTINATION_BRANCH"
