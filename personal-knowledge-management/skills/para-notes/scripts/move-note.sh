#!/bin/bash
# Move a note between PARA categories, updating frontmatter
# Usage: move-note.sh <file-path> <target-category>
# Example: move-note.sh "1 - Projects/my-project/Note.md" archive

set -euo pipefail

FILE_PATH="${1:?Usage: move-note.sh <file-path> <target-category>}"
TARGET_CATEGORY="${2:?Usage: move-note.sh <file-path> <target-category>}"

VAULT_ROOT="${VAULT_ROOT:-.}"
DATE=$(date +%Y-%m-%d)

# Resolve full path if relative
if [[ "$FILE_PATH" != /* ]]; then
    FILE_PATH="$VAULT_ROOT/$FILE_PATH"
fi

if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File not found: $FILE_PATH"
    exit 1
fi

# Map target category to folder
case "$TARGET_CATEGORY" in
    project)  TARGET_FOLDER="1 - Projects" ;;
    area)     TARGET_FOLDER="2 - Areas" ;;
    resource) TARGET_FOLDER="3 - Resources" ;;
    archive)  TARGET_FOLDER="4 - Archives" ;;
    *)
        echo "Error: target category must be one of: project, area, resource, archive"
        exit 1
        ;;
esac

# Get the note's parent subfolder name and filename
FILENAME=$(basename "$FILE_PATH")
SUBFOLDER=$(basename "$(dirname "$FILE_PATH")")

# Create destination
DEST_DIR="$VAULT_ROOT/$TARGET_FOLDER/$SUBFOLDER"
mkdir -p "$DEST_DIR"
DEST_PATH="$DEST_DIR/$FILENAME"

# Update frontmatter category and modified date
sed -i '' "s/^category:.*$/category: $TARGET_CATEGORY/" "$FILE_PATH"
sed -i '' "s/^modified:.*$/modified: $DATE/" "$FILE_PATH"

# Move the file
mv "$FILE_PATH" "$DEST_PATH"

# Clean up empty source directory
SOURCE_DIR=$(dirname "$FILE_PATH")
if [ -z "$(ls -A "$SOURCE_DIR")" ]; then
    rmdir "$SOURCE_DIR"
fi

echo "Moved: $FILENAME → $TARGET_FOLDER/$SUBFOLDER/"
