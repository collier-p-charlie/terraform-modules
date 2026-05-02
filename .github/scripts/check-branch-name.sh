#!/bin/bash

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
SOURCE_BRANCH=${1:-$CURRENT_BRANCH}
TARGET_BRANCH=$2

REGEX_TAG_MATCH="^[A-Za-z0-9]+(-[A-Za-z0-9]+)+\.v[0-9]+\.[0-9]+\.[0-9]+$"
MODULE_TAG=${SOURCE_BRANCH#*/}

if [[ ! $SOURCE_BRANCH =~ ^(feature|bugfix)/.+$ ]]; then
  echo "Branch name '$SOURCE_BRANCH' must be of the form 'feature/*' or 'bugfix/*'"
  exit 1
fi

if [[ ! $MODULE_TAG =~ $REGEX_TAG_MATCH ]]; then
  echo "Module tag (branch) should be of the form module(-label).vX.Y.Z"
  exit 1
fi

if [[ $TARGET_BRANCH ]] && [[ ! $TARGET_BRANCH == main ]]; then
  echo "Target branch must be 'main'" && exit 1
fi

echo "Branch name $SOURCE_BRANCH is valid"
