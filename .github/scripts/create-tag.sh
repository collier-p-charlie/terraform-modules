#!/bin/bash

TAGS=$@

for TAG in $TAGS; do
  echo "Creating tag $TAG."
  git tag $TAG -m "Release $TAG"
  git push origin $TAG
done
