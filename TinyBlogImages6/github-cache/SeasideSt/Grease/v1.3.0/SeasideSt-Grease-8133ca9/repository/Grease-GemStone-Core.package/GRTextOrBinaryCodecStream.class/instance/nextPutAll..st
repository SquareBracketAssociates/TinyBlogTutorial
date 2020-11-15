streaming
nextPutAll: aString
	binary
		ifTrue: [ stream nextPutAll: aString asString ]
		ifFalse: [ stream nextPutAll: aString ]