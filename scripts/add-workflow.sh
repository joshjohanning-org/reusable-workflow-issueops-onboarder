#!/bin/bash

# Relative path to the file to be replaced
FILE="./.github/workflows/ci.yml"

# Full path to the file to copy in
REPLACE_WITH_FILE="$1"

if [ -f "$FILE" ]; then
  echo "File $FILE exists."
else
  echo "File $FILE does not exist. Creating from $REPLACE_WITH_FILE...."
  mkdir -p ./.github/workflows
  cp $REPLACE_WITH_FILE $FILE
  echo "File $FILE created."
fi
