services
logError: aDescription title: aString shouldCommit: shouldCommit

	| stdout stack logStream |
	stack := GsProcess stackReportToLevel: 300.
	self saveLogEntry: (ObjectLogEntry error: aString object: { aDescription. stack. }) shouldCommit: shouldCommit.
	stdout := GsFile stdoutServer.
	stdout nextPutAll: '----------- ', aString, ' ERROR Encountered: ', DateAndTime now printString.
	stdout cr.
	stdout nextPutAll: aDescription.
	stdout cr.
	stdout nextPutAll: stack.
	stdout nextPutAll: '-----------'.
	stdout cr.
	stdout close.