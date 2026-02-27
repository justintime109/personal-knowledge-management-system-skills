-- List all inbox items for processing
-- Usage: osascript process-inbox.applescript
-- Output: JSON-like list of inbox tasks with name, note, and creation date
on run
    set output to ""

    tell application "OmniFocus"
        tell default document
            set inboxItems to inbox tasks
            set itemCount to count of inboxItems

            if itemCount is 0 then
                return "Inbox is empty. Nothing to process."
            end if

            set output to "Inbox items (" & itemCount & "):" & linefeed & linefeed

            repeat with i from 1 to itemCount
                set t to item i of inboxItems
                set taskName to name of t
                set taskNote to note of t
                set taskDate to creation date of t

                set output to output & i & ". " & taskName & linefeed
                if taskNote is not "" then
                    set output to output & "   Note: " & taskNote & linefeed
                end if
                set output to output & "   Created: " & (taskDate as string) & linefeed
                set output to output & linefeed
            end repeat
        end tell
    end tell

    return output
end run
