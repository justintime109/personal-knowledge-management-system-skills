---
name: gtd-omnifocus
description: This skill should be used when the user asks to "add a task", "capture to inbox", "process inbox", "weekly review", "plan a project", "what are my next actions", "GTD review", "organize tasks", "clear inbox", or mentions OmniFocus, GTD methodology, task management, or next actions.
---

# GTD Task Management — OmniFocus

Manage tasks in OmniFocus using the Getting Things Done methodology. Automates capture, inbox processing, project planning, and weekly reviews via AppleScript.

## Prerequisites

- OmniFocus must be installed and running on macOS
- AppleScript execution must be permitted

## Core Workflows

### Capture to Inbox

To quickly add items to the OmniFocus inbox:

1. Run `scripts/capture-task.applescript` with the task name and optional note
2. The task lands in the OmniFocus inbox for later processing
3. Apply the two-minute rule: if it takes less than 2 minutes, do it now instead of capturing

### Process Inbox

To clarify and organize inbox items:

1. Run `scripts/process-inbox.applescript` to retrieve all inbox items
2. For each item, walk through the GTD clarifying questions (see `references/gtd-methodology.md`):
   - Is it actionable?
   - If yes: What's the next action? Does it belong to a project?
   - If no: Trash, incubate (someday/maybe), or file as reference
3. Present each item to the user with a recommended action
4. Apply changes in OmniFocus (assign project, set context/tag, set defer/due dates)

### Project Planning

To break down a project into actionable tasks:

1. Identify the desired outcome — what does "done" look like?
2. Brainstorm all tasks needed
3. Organize into sequential or parallel actions
4. Identify the next physical action for each sequence
5. Assign contexts (tags) and defer/due dates
6. Create in OmniFocus using `scripts/capture-task.applescript`

### Weekly Review

To perform a GTD weekly review:

1. Run `scripts/weekly-review.applescript` to gather review data
2. Walk through each review step with the user:
   - **Get clear**: Process inbox to zero, collect loose items
   - **Get current**: Review next actions, check calendar, review active projects
   - **Get creative**: Review someday/maybe list, trigger new ideas
3. Report: projects without next actions, overdue items, stale projects
4. See `references/gtd-methodology.md` for the full weekly review checklist

## OmniFocus Mapping

| GTD Concept | OmniFocus Element |
|---|---|
| Inbox | Inbox |
| Project | Project |
| Area of Responsibility | Folder |
| Context | Tag |
| Next Action | First available task |
| Someday/Maybe | On Hold project or tag |
| Waiting For | Tag |

## Scripts

- **`scripts/capture-task.applescript`** — Add a task to OmniFocus inbox. Args: task name, optional note.
- **`scripts/process-inbox.applescript`** — Query and return all inbox items for processing.
- **`scripts/list-projects.applescript`** — List active projects with their next available actions.
- **`scripts/weekly-review.applescript`** — Gather review data: stale projects, missing next actions, inbox count, due soon.

## Reference Files

For detailed GTD methodology and OmniFocus structure, consult:
- **`references/gtd-methodology.md`** — GTD five phases, inbox processing decision tree, weekly review checklist, two-minute rule
- **`references/omnifocus-structure.md`** — How GTD maps to OmniFocus folders, projects, tags, and perspectives
