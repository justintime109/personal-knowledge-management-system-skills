-- Capture a task to OmniFocus inbox
-- Usage: osascript capture-task.applescript "Task name" ["Optional note"]
on run argv
    set taskName to item 1 of argv
    set taskNote to ""
    if (count of argv) > 1 then
        set taskNote to item 2 of argv
    end if

    tell application "OmniFocus"
        tell default document
            make new inbox task with properties {name:taskName, note:taskNote}
        end tell
    end tell

    return "Captured: " & taskName
end run
