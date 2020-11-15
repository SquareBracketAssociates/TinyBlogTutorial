streaming
crlf
	binary
		ifTrue: [
			stream nextPut: 13.
			stream nextPut: 10 ]
		ifFalse: [
			stream nextPut: Character cr.
			stream nextPut: Character lf ]