-- List active projects with their next available action
-- Usage: osascript list-projects.applescript
on run
    set output to ""

    tell application "OmniFocus"
        tell default document
            set activeProjects to every flattened project whose status is active
            set projectCount to count of activeProjects

            if projectCount is 0 then
                return "No active projects found."
            end if

            set output to "Active Projects (" & projectCount & "):" & linefeed & linefeed

            repeat with p in activeProjects
                set projName to name of p
                set projFolder to ""
                try
                    set projFolder to name of container of p
                end try

                -- Get next available task
                set nextAction to "NO NEXT ACTION"
                try
                    set availableTasks to (every flattened task of p whose completed is false and effectively dropped is false)
                    if (count of availableTasks) > 0 then
                        set nextAction to name of item 1 of availableTasks
                    end if
                end try

                set taskCount to count of (every flattened task of p whose completed is false)

                if projFolder is not "" then
                    set output to output & "[" & projFolder & "] "
                end if
                set output to output & projName & " (" & taskCount & " remaining)" & linefeed
                set output to output & "   Next: " & nextAction & linefeed
                set output to output & linefeed
            end repeat
        end tell
    end tell

    return output
end run
