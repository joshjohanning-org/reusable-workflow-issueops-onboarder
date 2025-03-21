#!/bin/bash

# get the current date and time
# only using this for testing purposes so I can stamp the file with the current time/date if the file already exists
DATE=$(date +"%Y-%m-%d %H:%M:%S")


########################################
# Workflow
########################################

# Relative path to the file to be replaced
FILE_WORKFLOW="./.github/workflows/ci.yml"

# Full path to the file to copy in
REPLACE_WITH_FILE_WORKFLOW="$1"

if [ -f "$FILE_WORKFLOW" ]; then
  echo "File $FILE_WORKFLOW exists."
  cp $REPLACE_WITH_FILE_WORKFLOW $FILE_WORKFLOW
  # get the current date
  printf '\n\n# last updated: %s\n' "$DATE" >> "$FILE_WORKFLOW"
  echo "File $FILE_WORKFLOW updated."
else
  echo "File $FILE_WORKFLOW does not exist. Creating from $REPLACE_WITH_FILE_WORKFLOW...."
  mkdir -p ./.github/workflows
  cp $REPLACE_WITH_FILE_WORKFLOW $FILE_WORKFLOW
  echo "File $FILE_WORKFLOW created."
fi

########################################
# Copilot Instructions File
########################################

FILE_COPILOT="./.github/copilot-instructions.md"

# Full path to the file to copy in
REPLACE_WITH_FILE_COPILOT="$2"

if [ -f "$FILE_COPILOT" ]; then
  echo "File $FILE_COPILOT exists."
  cp $REPLACE_WITH_FILE_COPILOT $FILE_COPILOT
  printf '\n\n_last updated: %s_\n' "$DATE" >> "$FILE_COPILOT"
  echo "File $FILE_COPILOT updated."
else
  echo "File $FILE_COPILOT does not exist. Creating from $REPLACE_WITH_FILE_COPILOT...."
  mkdir -p ./.github
  cp $REPLACE_WITH_FILE_COPILOT $FILE_COPILOT
  echo "File $FILE_COPILOT created."
fi


########################################
# Dependabot File
########################################

ADD_DEPENDABOT=$3

if [ "$ADD_DEPENDABOT" != "true" ]; then
  echo "Skipping Dependabot file creation."
  exit 0
else
  echo "Creating Dependabot file."
  # Relative path to the file to be replaced
  FILE_DEPENDABOT="./.github/dependabot.yml"

  # Check if the file exists
  if [ -f "$FILE_DEPENDABOT" ]; then
    echo "File $FILE_DEPENDABOT exists."
    # Check if "package-ecosystem: github-actions" exists in the file
    if [[ $(yq e '[.updates[] | select(.package-ecosystem == "github-actions")] | length' $FILE_DEPENDABOT) -gt 0 ]]; then
      echo '"package-ecosystem: github-actions" exists in the file.'
    else
      echo '"package-ecosystem: github-actions" does not exist in the file.'
      yq e '.updates += [{"package-ecosystem": "github-actions", "directory": "/", "schedule": {"interval": "daily"}}]' -i $FILE_DEPENDABOT
      echo '"package-ecosystem: github-actions" added to the file.'
    fi
  else
    echo "File $FILE_DEPENDABOT does not exist. Creating..."
    mkdir -p ./.github
    # Create the file with initial content
    yq e '.version = "2"' - | \
    yq e '.updates = [{"package-ecosystem": "github-actions", "directory": "/", "schedule": {"interval": "daily"}}]' - > "$FILE_DEPENDABOT"
    echo "File $FILE_DEPENDABOT created."
  fi
fi
