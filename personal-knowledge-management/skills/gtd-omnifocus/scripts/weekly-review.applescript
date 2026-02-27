-- Gather data for GTD weekly review
-- Usage: osascript weekly-review.applescript
on run
    set output to "=== GTD Weekly Review ===" & linefeed & linefeed

    tell application "OmniFocus"
        tell default document
            -- Inbox count
            set inboxCount to count of inbox tasks
            set output to output & "--- Inbox ---" & linefeed
            set output to output & "Items to process: " & inboxCount & linefeed & linefeed

            -- Projects without next actions
            set output to output & "--- Projects Without Next Actions ---" & linefeed
            set activeProjects to every flattened project whose status is active
            set orphanFound to false
            repeat with p in activeProjects
                set availableTasks to (every flattened task of p whose completed is false and effectively dropped is false)
                if (count of availableTasks) is 0 then
                    set orphanFound to true
                    set output to output & "  ! " & name of p & linefeed
                end if
            end repeat
            if orphanFound is false then
                set output to output & "  (all projects have next actions)" & linefeed
            end if
            set output to output & linefeed

            -- Due soon (next 7 days)
            set output to output & "--- Due Within 7 Days ---" & linefeed
            set sevenDays to (current date) + (7 * days)
            set dueSoonFound to false
            set allTasks to every flattened task whose completed is false and effectively dropped is false
            repeat with t in allTasks
                try
                    set dueDate to due date of t
                    if dueDate is not missing value and dueDate < sevenDays then
                        set dueSoonFound to true
                        set output to output & "  " & name of t & " (due: " & (dueDate as string) & ")" & linefeed
                    end if
                end try
            end repeat
            if dueSoonFound is false then
                set output to output & "  (nothing due soon)" & linefeed
            end if
            set output to output & linefeed

            -- Stale projects (no completed tasks in 14+ days)
            set output to output & "--- Project Summary ---" & linefeed
            set output to output & "Active projects: " & (count of activeProjects) & linefeed
            set onHoldProjects to every flattened project whose status is on hold
            set output to output & "On hold (someday/maybe): " & (count of onHoldProjects) & linefeed
            set output to output & linefeed

            -- Waiting for items
            set output to output & "--- Waiting For ---" & linefeed
            set waitingFound to false
            try
                set waitingTag to first flattened tag whose name is "waiting-for"
                set waitingTasks to every flattened task whose completed is false and (primary tag is waitingTag)
                repeat with t in waitingTasks
                    set waitingFound to true
                    set output to output & "  " & name of t & linefeed
                end repeat
            end try
            if waitingFound is false then
                set output to output & "  (no waiting-for items)" & linefeed
            end if
        end tell
    end tell

    return output
end run
