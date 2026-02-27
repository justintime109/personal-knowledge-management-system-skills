# Obsidian Vault Patterns for PARA

## Folder Structure

```
vault-root/
├── 1 - Projects/
│   ├── website-redesign/
│   │   ├── Website Redesign.md
│   │   ├── Wireframes.md
│   │   └── Tech Stack Decision.md
│   └── tax-filing-2026/
│       └── Tax Filing 2026.md
├── 2 - Areas/
│   ├── health/
│   │   ├── Exercise Log.md
│   │   └── Nutrition Notes.md
│   └── finances/
│       └── Budget Overview.md
├── 3 - Resources/
│   ├── programming/
│   │   └── Python Tips.md
│   └── cooking/
│       └── Favorite Recipes.md
├── 4 - Archives/
│   └── completed-projects/
│       └── old-website/
│           └── Old Website.md
└── templates/
    └── note-template.md
```

### Naming Conventions
- Folder prefixes (`1 -`, `2 -`, etc.) keep PARA categories in order in the file explorer
- Subfolder names use kebab-case
- Note filenames use Title Case with spaces (Obsidian-friendly)
- One subfolder per project/area/resource topic

## Frontmatter Standard

Every note MUST have this frontmatter:

```yaml
---
title: Note Title
category: project | area | resource | archive
tags: [relevant, tags, here]
created: YYYY-MM-DD
modified: YYYY-MM-DD
project: optional-project-name
area: optional-area-name
---
```

### Field Rules
- `category`: Must be one of: project, area, resource, archive
- `tags`: Array of lowercase, hyphenated tags
- `created`: Set once at creation, never changed
- `modified`: Updated on every edit
- `project`/`area`: Optional cross-reference to parent project or area

## Linking Patterns

### Within PARA categories
- Link freely between notes in the same project/area
- Use `[[Note Name]]` standard Obsidian wiki links

### Across PARA categories
- Link from Project notes to relevant Resource notes
- Link from Area notes to supporting Resource notes
- Avoid linking TO archive notes (they're inactive)

## Template

Standard note template for `scripts/create-note.sh`:

```markdown
---
title: {{title}}
category: {{category}}
tags: []
created: {{date}}
modified: {{date}}
---

# {{title}}


```
