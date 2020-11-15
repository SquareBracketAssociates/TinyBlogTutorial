streaming
nextPut: aCharacter
	| codePoint shouldEncode |
	codePoint := aCharacter codePoint.
	codePoint > 255
		ifTrue: [ ^ self nextPutAll: (String with: aCharacter) ].
	shouldEncode := Latin1ToUtf8Map at: codePoint + 1.
	shouldEncode = 1
		ifTrue: [ stream nextPutAll: (Latin1ToUtf8Encodings at: codePoint + 1) ]
		ifFalse: [ stream nextPut: aCharacter ]
	