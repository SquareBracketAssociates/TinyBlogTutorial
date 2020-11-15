startup
removeFromStartUpList: aClass
	"Remove aClass from the startup list in the system."

	SessionManager default unregisterClassNamed: aClass name