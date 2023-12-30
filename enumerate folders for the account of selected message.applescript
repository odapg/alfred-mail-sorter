use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions
use framework "Foundation"

-- classes, constants, and enums used
property NSJSONWritingPrettyPrinted : a reference to 1
property NSJSONSerialization : a reference to current application's NSJSONSerialization

set MBL to {}
set mailboxList to {}
set ca to current application


tell application "Mail"
	
	try
		if selection is {} then error
		set theMessage to the first item of (selection as list)
		set currentMailbox to mailbox of theMessage
		set theAccount to the account of currentMailbox
	end try
	
	set allAccountMailboxes to every mailbox of theAccount
	
	repeat with eachMailbox in allAccountMailboxes
		
		set thisReccord to {uid:(name of eachMailbox) & "-" & (name of theAccount), title:(name of eachMailbox), subtitle:(name of theAccount), arg:[(name of eachMailbox), (name of theAccount)], valid:true, match:(name of eachMailbox)}
		set the end of MBL to thisReccord
		
	end repeat
	set |items| to {|items|:MBL}
	set MBL to NSJSONSerialization's dataWithJSONObject:|items| options:NSJSONWritingPrettyPrinted |error|:(missing value)
	set mailboxList to (ca's NSString's alloc()'s initWithData:MBL encoding:(ca's NSUTF8StringEncoding)) as text

	
end tell