# OmniFocus Structure for GTD

## Mapping GTD to OmniFocus

### Folders = Areas of Responsibility
Top-level folders represent life areas (GTD "Areas of Focus"):
- Work
- Personal
- Health
- Finances
- Side Projects

Each folder contains projects related to that area.

### Projects = GTD Projects
Any outcome requiring 2+ actions becomes an OmniFocus project.

**Project types:**
- **Sequential**: Tasks must be done in order (default for most)
- **Parallel**: Tasks can be done in any order
- **Single Actions**: A list of unrelated tasks grouped by area (e.g., "Household Errands")

**Project status:**
- **Active**: Has next actions, being worked on
- **On Hold**: Paused (someday/maybe projects live here)
- **Completed**: Done, will auto-clean
- **Dropped**: Abandoned

### Tags = Contexts
Tags represent the context needed to do the action:

**Location-based:**
- @home
- @office
- @errands

**Tool-based:**
- @computer
- @phone
- @email

**People-based:**
- @boss
- @partner
- @team

**Energy-based:**
- @deep-work (high focus required)
- @low-energy (mindless tasks)

**Special:**
- @waiting-for (delegated items — add person in note)
- @someday-maybe (if using tags instead of On Hold projects)
- @agenda (items to discuss with specific people)

### Perspectives = GTD Views
Custom perspectives for GTD workflows:

- **Inbox**: Default — items to process
- **Next Actions**: Group by tag, show first available from each project
- **Waiting For**: Filter by @waiting-for tag
- **Weekly Review**: Show all projects, check for orphans
- **Due Soon**: Items due in the next 7 days
- **Flagged**: High-priority items

### Defer vs Due Dates

- **Defer date**: "Don't show this until..." — hides the task until the date arrives
- **Due date**: "This must be done by..." — shows as overdue if missed

**Best practices:**
- Use defer dates liberally — keeps lists clean
- Use due dates sparingly — only for real deadlines
- Avoid fake due dates (aspirational dates erode trust in the system)

### Review Intervals

Set review intervals on projects:
- Active projects: review weekly
- On Hold / Someday: review monthly
- Single Action lists: review weekly

OmniFocus will flag projects for review based on these intervals.

## AppleScript Integration

### Key OmniFocus AppleScript Objects

- `default document` — the main OmniFocus database
- `inbox tasks` — tasks in the inbox
- `flattened projects` — all projects regardless of folder
- `flattened tasks` — all tasks regardless of project
- `flattened tags` — all tags

### Common Patterns

**Get inbox tasks:**
```applescript
tell application "OmniFocus"
    tell default document
        set inboxTasks to inbox tasks
    end tell
end tell
```

**Create a task:**
```applescript
tell application "OmniFocus"
    tell default document
        make new inbox task with properties {name:"Task name", note:"Optional note"}
    end tell
end tell
```

**Get active projects:**
```applescript
tell application "OmniFocus"
    tell default document
        set activeProjects to every flattened project whose status is active
    end tell
end tell
```
