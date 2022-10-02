#!/bin/sh

set -e

SOURCE_REPO="$1"
SOURCE_BRANCH="$2"
DESTINATION_REPO="$3"
DESTINATION_BRANCH="${4:-$2}"
REPO_DIR="repo"

echo "SOURCE=$SOURCE_REPO:$SOURCE_BRANCH"
echo "DESTINATION=$DESTINATION_REPO:$DESTINATION_BRANCH"

rm -fr "$REPO_DIR"
git clone "$SOURCE_REPO" "$REPO_DIR" --origin source && cd "$REPO_DIR"

git remote add mirror "$DESTINATION_REPO"
git fetch source '+refs/heads/*:refs/heads/*' --update-head-ok

git push -f mirror "$SOURCE_BRANCH:$DESTINATION_BRANCH"
