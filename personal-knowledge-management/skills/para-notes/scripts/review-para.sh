#!/bin/bash
# Scan PARA vault and report items needing attention
# Usage: review-para.sh [vault-root]
# Defaults to current directory

set -euo pipefail

VAULT_ROOT="${1:-.}"

STALE_DAYS=30
RESOURCE_STALE_DAYS=90

echo "=== PARA Review: $VAULT_ROOT ==="
echo ""

# Check PARA structure
PARA_FOUND=false
for folder in "1 - Projects" "2 - Areas" "3 - Resources" "4 - Archives"; do
    if [ -d "$VAULT_ROOT/$folder" ]; then
        PARA_FOUND=true
    fi
done

if [ "$PARA_FOUND" = false ]; then
    echo "Error: No PARA folders found in '$VAULT_ROOT'."
    echo "Expected: '1 - Projects/', '2 - Areas/', '3 - Resources/', '4 - Archives/'"
    exit 1
fi

# Stale projects (no edits in 30+ days)
echo "--- Stale Projects (no edits in ${STALE_DAYS}+ days) ---"
if [ -d "$VAULT_ROOT/1 - Projects" ]; then
    FOUND=false
    while IFS= read -r -d '' file; do
        FOUND=true
        DAYS_AGO=$(( ($(date +%s) - $(stat -f %m "$file")) / 86400 ))
        echo "  [$DAYS_AGO days] $file"
    done < <(find "$VAULT_ROOT/1 - Projects" -name "*.md" -mtime +${STALE_DAYS} -print0 2>/dev/null)
    if [ "$FOUND" = false ]; then
        echo "  (none)"
    fi
else
    echo "  (folder not found)"
fi
echo ""

# Empty areas (subfolders with no .md files)
echo "--- Empty Areas (no notes) ---"
if [ -d "$VAULT_ROOT/2 - Areas" ]; then
    FOUND=false
    for dir in "$VAULT_ROOT/2 - Areas"/*/; do
        [ -d "$dir" ] || continue
        COUNT=$(find "$dir" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
        if [ "$COUNT" -eq 0 ]; then
            FOUND=true
            echo "  $(basename "$dir")"
        fi
    done
    if [ "$FOUND" = false ]; then
        echo "  (none)"
    fi
else
    echo "  (folder not found)"
fi
echo ""

# Stale resources (no access in 90+ days)
echo "--- Stale Resources (no edits in ${RESOURCE_STALE_DAYS}+ days) ---"
if [ -d "$VAULT_ROOT/3 - Resources" ]; then
    FOUND=false
    while IFS= read -r -d '' file; do
        FOUND=true
        DAYS_AGO=$(( ($(date +%s) - $(stat -f %m "$file")) / 86400 ))
        echo "  [$DAYS_AGO days] $file"
    done < <(find "$VAULT_ROOT/3 - Resources" -name "*.md" -mtime +${RESOURCE_STALE_DAYS} -print0 2>/dev/null)
    if [ "$FOUND" = false ]; then
        echo "  (none)"
    fi
else
    echo "  (folder not found)"
fi
echo ""

# Summary counts
echo "--- Summary ---"
for folder in "1 - Projects" "2 - Areas" "3 - Resources" "4 - Archives"; do
    if [ -d "$VAULT_ROOT/$folder" ]; then
        COUNT=$(find "$VAULT_ROOT/$folder" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
        echo "  $folder: $COUNT notes"
    fi
done
