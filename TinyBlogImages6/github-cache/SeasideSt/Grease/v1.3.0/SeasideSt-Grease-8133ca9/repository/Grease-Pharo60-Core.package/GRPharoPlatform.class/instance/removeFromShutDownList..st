startup
removeFromShutDownList: aClass
	"Remove aClass from the shutdown list in the system."

	SessionManager default unregisterClassNamed: aClass name