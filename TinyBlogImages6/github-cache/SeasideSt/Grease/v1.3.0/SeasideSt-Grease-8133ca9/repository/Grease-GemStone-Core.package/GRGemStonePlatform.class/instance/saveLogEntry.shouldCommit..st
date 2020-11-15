services
saveLogEntry: anObjectLogEntry shouldCommit: shouldCommit
	"Does an abort and commit, if not already in transaction"
	
	| stdout |
	stdout := GsFile stdoutServer.
	stdout nextPutAll: '----------- ', anObjectLogEntry labelString, ' LOG ENTRY: ', anObjectLogEntry objectString.
	stdout nextPutAll: '-----------'.
	stdout cr.
	stdout close.
	shouldCommit  
		ifTrue: [ self doTransaction: [ anObjectLogEntry addToLog ]]
		ifFalse: [ anObjectLogEntry addToLog ].