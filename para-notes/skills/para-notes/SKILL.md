---
name: para-notes
description: This skill should be used when the user asks to "create a note", "file this note", "organize notes", "PARA review", "move note to archive", "find notes about", "weekly note review", "what project is this note for", or mentions PARA methodology, note organization, or Obsidian vault management.
---

# PARA Notes — Obsidian Vault Management

Manage notes in an Obsidian vault using the PARA method (Projects, Areas, Resources, Archives). Supports the full note lifecycle: capture, organize, review, and retrieve.

## Vault Detection

The current working directory is assumed to be the Obsidian vault root. Verify by checking for a PARA folder structure:

```
vault-root/
├── 1 - Projects/
├── 2 - Areas/
├── 3 - Resources/
└── 4 - Archives/
```

If no PARA folders are found, ask the user to confirm the vault path before proceeding.

## Core Workflows

### Capture & File a Note

To create and file a new note:

1. Determine the PARA category using the decision tree in `references/para-methodology.md`
2. Run `scripts/create-note.sh` with the title, category, and optional tags
3. The script creates a markdown file with frontmatter in the correct PARA folder

Quick categorization guide:
- **Project** — Has a deadline or specific outcome. Ask: "What does done look like?"
- **Area** — Ongoing responsibility with a standard to maintain. No end date.
- **Resource** — Topic of interest for future reference. No active commitment.
- **Archive** — Inactive items from any of the above three categories.

### Review & Reorganize

To perform a PARA review:

1. Run `scripts/review-para.sh` to scan the vault
2. The script reports: projects with no edits in 30+ days, areas with zero notes, and potential archive candidates
3. Walk through the results with the user, suggesting actions:
   - Stale projects: archive or reactivate with next action?
   - Empty areas: remove or populate?
   - Resources not accessed in 90+ days: archive?
4. Use `scripts/move-note.sh` to relocate notes between categories

### Search & Retrieve

To find notes across the vault:

1. Use grep/glob to search file contents and frontmatter across all PARA folders
2. Present results grouped by PARA category
3. Show frontmatter metadata (tags, dates, category) alongside matches

## Frontmatter Convention

Every note should have this frontmatter:

```yaml
---
title: Note Title
category: project | area | resource | archive
tags: [tag1, tag2]
created: YYYY-MM-DD
modified: YYYY-MM-DD
---
```

## Scripts

- **`scripts/create-note.sh`** — Create a note with frontmatter in the correct PARA folder. Args: title, category, tags.
- **`scripts/move-note.sh`** — Move a note between PARA categories, updating frontmatter. Args: file path, target category.
- **`scripts/review-para.sh`** — Scan vault and report stale projects, empty areas, archive candidates.

## Reference Files

For detailed methodology and Obsidian-specific patterns, consult:
- **`references/para-methodology.md`** — Full PARA definitions, decision tree for categorization, promotion/demotion rules
- **`references/obsidian-patterns.md`** — Vault folder structure, frontmatter conventions, linking patterns, templates
