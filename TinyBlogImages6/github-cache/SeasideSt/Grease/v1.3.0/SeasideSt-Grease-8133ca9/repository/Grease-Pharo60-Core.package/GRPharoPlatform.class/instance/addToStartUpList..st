startup
addToStartUpList: aClass
	"Add anObject to the startup-list of the system. On startup the message #startUp will be sent to anObject."

	SessionManager default registerUserClassNamed: aClass name.