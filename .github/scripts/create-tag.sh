#!/bin/bash

TAG=$1

echo "Creating tag $TAG."
git tag $TAG -m "Release $TAG"
git push origin $TAG
