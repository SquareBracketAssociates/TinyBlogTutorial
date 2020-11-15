file library
fileStreamOn: aString do: aBlock binary: aBoolean
	^ aBoolean
		ifTrue: [
			FileStream fileNamed: aString do: [ :stream |
				stream binary.
				aBlock value: stream ] ]
		ifFalse: [
			MultiByteFileStream fileNamed: aString do: [ :stream |
				stream
					ascii;
					wantsLineEndConversion: true.
					aBlock value: stream ] ]