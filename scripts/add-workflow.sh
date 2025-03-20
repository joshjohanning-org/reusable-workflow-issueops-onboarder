#!/bin/bash

# get the current date and time
DATE=$(date +"%Y-%m-%d %H:%M:%S")


# Relative path to the file to be replaced
FILE="./.github/workflows/ci.yml"

# Full path to the file to copy in
REPLACE_WITH_FILE="$1"

if [ -f "$FILE" ]; then
  echo "File $FILE exists."
  cp $REPLACE_WITH_FILE $FILE
  # get the current date
  printf '\n\n_last updated: %s\n' "$DATE" >> "$FILE"
  echo "File $FILE updated."
else
  echo "File $FILE does not exist. Creating from $REPLACE_WITH_FILE...."
  mkdir -p ./.github/workflows
  cp $REPLACE_WITH_FILE $FILE
  echo "File $FILE created."
fi

FILE_COPILOT="./.github/copilot-instructions.md"

# Full path to the file to copy in
REPLACE_WITH_FILE_COPILOT="$2"

if [ -f "$FILE_COPILOT" ]; then
  echo "File $FILE_COPILOT exists."
  cp $REPLACE_WITH_FILE_COPILOT $FILE_COPILOT
  printf '\n\n_last updated: %s\n' "$DATE" >> "$FILE_COPILOT"
  echo "File $FILE_COPILOT updated."
else
  echo "File $FILE_COPILOT does not exist. Creating from $REPLACE_WITH_FILE_COPILOT...."
  mkdir -p ./.github
  cp $REPLACE_WITH_FILE_COPILOT $FILE_COPILOT
  echo "File $FILE_COPILOT created."
fi
