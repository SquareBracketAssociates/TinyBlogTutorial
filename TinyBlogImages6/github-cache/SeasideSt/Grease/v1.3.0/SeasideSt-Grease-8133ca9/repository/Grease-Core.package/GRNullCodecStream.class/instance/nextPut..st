streaming
nextPut: aCharacterOrByte
	aCharacterOrByte isCharacter
		ifTrue: [ stream nextPut: aCharacterOrByte ]
		ifFalse: [ stream nextPut: (Character codePoint: aCharacterOrByte) ]