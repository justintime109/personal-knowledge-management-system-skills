#!/bin/bash
# Create a new note in the correct PARA category folder
# Usage: create-note.sh <title> <category> [tags...]
# Example: create-note.sh "My New Note" project tag1 tag2

set -euo pipefail

TITLE="${1:?Usage: create-note.sh <title> <category> [tags...]}"
CATEGORY="${2:?Usage: create-note.sh <title> <category> [tags...]}"
shift 2
TAGS=("$@")

VAULT_ROOT="${VAULT_ROOT:-.}"
DATE=$(date +%Y-%m-%d)

# Map category to folder
case "$CATEGORY" in
    project)  FOLDER="1 - Projects" ;;
    area)     FOLDER="2 - Areas" ;;
    resource) FOLDER="3 - Resources" ;;
    archive)  FOLDER="4 - Archives" ;;
    *)
        echo "Error: category must be one of: project, area, resource, archive"
        exit 1
        ;;
esac

# Check PARA structure exists
if [ ! -d "$VAULT_ROOT/$FOLDER" ]; then
    echo "Error: PARA folder '$VAULT_ROOT/$FOLDER' not found."
    echo "Is '$VAULT_ROOT' the correct vault path?"
    exit 1
fi

# Build tags YAML array
TAGS_YAML="[]"
if [ ${#TAGS[@]} -gt 0 ]; then
    TAGS_YAML="[$(printf '"%s", ' "${TAGS[@]}" | sed 's/, $//')]"
fi

# Create subfolder from title (kebab-case)
SUBFOLDER=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')
DEST_DIR="$VAULT_ROOT/$FOLDER/$SUBFOLDER"
mkdir -p "$DEST_DIR"

# Create note file
FILE_PATH="$DEST_DIR/$TITLE.md"

cat > "$FILE_PATH" << EOF
---
title: $TITLE
category: $CATEGORY
tags: $TAGS_YAML
created: $DATE
modified: $DATE
---

# $TITLE

EOF

echo "Created: $FILE_PATH"
