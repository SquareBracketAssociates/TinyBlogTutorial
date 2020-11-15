streaming
next
	| character |
	character := converter nextFromStream: stream.
	^ character isNil
		ifFalse: [ character asCharacter ]