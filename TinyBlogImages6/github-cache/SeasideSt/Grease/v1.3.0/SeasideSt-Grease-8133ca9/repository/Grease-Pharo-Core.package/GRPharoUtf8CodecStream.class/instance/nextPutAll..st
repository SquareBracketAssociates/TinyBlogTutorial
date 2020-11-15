streaming
nextPutAll: aString
	aString isByteString
		ifTrue: [ self encodeFast: aString ]
		ifFalse: [ self encodeDefault: aString ]