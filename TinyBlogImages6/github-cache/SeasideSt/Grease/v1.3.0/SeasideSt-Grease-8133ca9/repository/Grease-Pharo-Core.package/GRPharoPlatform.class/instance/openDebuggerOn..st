exceptions
openDebuggerOn: anError
	| process |
	process := Processor activeProcess.
	"If we are running in the UI process, we don't want to suspend the active process. The
	error was presumably triggered while stepping in the Debugger. If we simply immediately
	signal an UnhandledError, the debugger will catch this and display the signaling context.
	It isn't perfect or pretty but it works."
	(ProcessBrowser isUIProcess: process)
		ifTrue: [
			UnhandledError signalForException: anError ]
		ifFalse: [
			WorldState addDeferredUIMessage: [
				process
					debug: anError signalerContext
					title: anError description
					full: true ].
			process suspend ]