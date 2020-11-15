streaming
next: anInteger
	| writeStream |
	writeStream := WriteStream on: String new.
	anInteger timesRepeat: [
		stream atEnd ifTrue: [ ^ writeStream contents ].
		writeStream nextPut: stream next asCharacter ].
	^ writeStream contents