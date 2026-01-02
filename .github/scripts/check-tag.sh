#!/bin/bash

TAG=$1

# Check if the tag already exists in the remote repository
if git ls-remote --tags origin "$TAG" | grep -q "$TAG"; then
  echo "Tag $TAG already exists."
  exit 1
fi
