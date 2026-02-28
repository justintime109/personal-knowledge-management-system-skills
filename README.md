# Personal Knowledge Management — Claude Code Plugins

Two independent Claude Code plugins for personal knowledge management:

- **para-notes** — Manage notes in an Obsidian vault using the PARA method
- **gtd-omnifocus** — Manage tasks in OmniFocus using GTD via AppleScript

Install either or both depending on your workflow.

## Installation

### From GitHub (recommended)

Add the marketplace, then install the plugins you want:

```bash
# Add the marketplace
/plugin marketplace add justintime109/personal-knowledge-management-system-skills

# Install both plugins
/plugin install para-notes
/plugin install gtd-omnifocus

# Or install just one
/plugin install para-notes
```

### From a local clone

If you've cloned the repo locally:

```bash
claude --plugin-dir ./para-notes --plugin-dir ./gtd-omnifocus
```

## para-notes

Capture, organize, review, and retrieve notes in an Obsidian vault structured with PARA (Projects, Areas, Resources, Archives).

### What it does

- **Capture & file** — Create notes in the right PARA category with proper frontmatter
- **Review & reorganize** — Find stale projects, empty areas, and archive candidates
- **Search & retrieve** — Find notes across all PARA categories

### Trigger phrases

> "create a note", "file this note", "PARA review", "organize notes", "move note to archive", "find notes about", "weekly note review"

### How it works

The skill assumes the current working directory is your Obsidian vault root. It looks for this folder structure:

```
vault-root/
├── 1 - Projects/
├── 2 - Areas/
├── 3 - Resources/
└── 4 - Archives/
```

If no PARA folders are found, Claude will ask you to confirm the vault path.

### Scripts

| Script | Purpose |
|--------|---------|
| `create-note.sh` | Create a note with frontmatter in the correct PARA folder |
| `move-note.sh` | Move a note between PARA categories, updating frontmatter |
| `review-para.sh` | Scan vault and report stale projects, empty areas, archive candidates |

### Setup

If you already have an Obsidian vault, add the PARA folders at the root:

```bash
cd /path/to/your/vault
mkdir "1 - Projects" "2 - Areas" "3 - Resources" "4 - Archives"
```

Then seed it with your existing notes:
- Active initiatives with a finish line → `1 - Projects/`
- Ongoing responsibilities (health, finances, career) → `2 - Areas/`
- Reference material and topics of interest → `3 - Resources/`
- Anything inactive you want to keep → `4 - Archives/`

Create subfolders within each category to group related notes (e.g., `1 - Projects/website-redesign/`).

### Usage examples

**Create a note:**
> You: "Create a note about Python decorators"
>
> Claude: Determines this is a Resource (topic of interest, no deadline), creates `3 - Resources/python-decorators/Python Decorators.md` with frontmatter.

**File an existing note:**
> You: "File this note about our Q3 launch plan"
>
> Claude: Asks clarifying questions — "Does this have a deadline or specific outcome?" — then files it as a Project.

**PARA review:**
> You: "Run a PARA review"
>
> Claude: Scans the vault, reports stale projects (no edits in 30+ days), empty areas, and resources not touched in 90+ days. Walks through each item asking whether to archive, reactivate, or leave as-is.

**Move a note:**
> You: "Move the website redesign project to archive, it's done"
>
> Claude: Moves all notes from `1 - Projects/website-redesign/` to `4 - Archives/website-redesign/`, updating frontmatter.

**Search:**
> You: "Find all my notes about authentication"
>
> Claude: Searches across all PARA folders, returns results grouped by category with tags and dates.

### Requirements

- An Obsidian vault (or any directory of markdown files) with PARA folder structure
- macOS (scripts use `stat -f` and `sed -i ''`)

---

## gtd-omnifocus

Capture tasks, process your inbox, plan projects, and run weekly reviews in OmniFocus using GTD methodology.

### What it does

- **Capture** — Add tasks to OmniFocus inbox
- **Process inbox** — Walk through each item with GTD clarifying questions
- **Project planning** — Break projects into next actions with contexts and dates
- **Weekly review** — Guided review of projects, inbox, someday/maybe, and waiting-for items

### Trigger phrases

> "add task", "capture to inbox", "process inbox", "weekly review", "plan project", "what are my next actions", "GTD review", "clear inbox"

### How it works

The skill uses AppleScript to communicate directly with OmniFocus. Claude guides you through GTD workflows while the scripts handle OmniFocus automation.

### Scripts

| Script | Purpose |
|--------|---------|
| `capture-task.applescript` | Add a task to OmniFocus inbox |
| `process-inbox.applescript` | List all inbox items for processing |
| `list-projects.applescript` | List active projects with next available actions |
| `weekly-review.applescript` | Gather data for a full GTD weekly review |

### Setup

The skill works with your existing OmniFocus setup. For the best GTD experience, set up these conventions:

**Folders** (areas of responsibility):
```
Work
Personal
Health
Finances
Side Projects
```

**Tags** (contexts):
```
@computer    @phone       @email       @errands
@home        @office      @deep-work   @low-energy
@waiting-for @agenda      @someday-maybe
```

**Perspectives** (optional but recommended):
- **Next Actions** — Group by tag, show first available from each project
- **Waiting For** — Filter by `@waiting-for` tag
- **Due Soon** — Items due in the next 7 days

The skill will work without these conventions, but having them in place means Claude can assign contexts and organize tasks more effectively.

### Usage examples

**Capture a task:**
> You: "Add a task to call the dentist about my appointment"
>
> Claude: Adds "Call the dentist about appointment" to your OmniFocus inbox.

**Process inbox:**
> You: "Help me process my inbox"
>
> Claude: Pulls all inbox items, then walks through each one: "Is this actionable? What's the next action? Does it belong to a project?" Helps you assign projects, tags, and dates.

**Plan a project:**
> You: "Help me plan out the kitchen renovation"
>
> Claude: Walks through GTD's Natural Planning Model — purpose, vision, brainstorm, organize, next actions. Creates tasks in OmniFocus with appropriate sequencing.

**Weekly review:**
> You: "Let's do a weekly review"
>
> Claude: Pulls review data from OmniFocus, then guides you through Get Clear (process inbox), Get Current (review projects, calendar, waiting-for), and Get Creative (someday/maybe, new ideas). Flags projects missing next actions and overdue items.

**Check next actions:**
> You: "What are my next actions?"
>
> Claude: Lists active projects with their next available action so you can pick what to work on.

### Requirements

- OmniFocus installed on macOS
- AppleScript execution permitted

---

## Plugin structure

```
para-notes/
├── .claude-plugin/plugin.json
└── skills/para-notes/
    ├── SKILL.md
    ├── references/
    │   ├── para-methodology.md
    │   └── obsidian-patterns.md
    └── scripts/
        ├── create-note.sh
        ├── move-note.sh
        └── review-para.sh

gtd-omnifocus/
├── .claude-plugin/plugin.json
└── skills/gtd-omnifocus/
    ├── SKILL.md
    ├── references/
    │   ├── gtd-methodology.md
    │   └── omnifocus-structure.md
    └── scripts/
        ├── capture-task.applescript
        ├── process-inbox.applescript
        ├── list-projects.applescript
        └── weekly-review.applescript
```

## License

MIT
