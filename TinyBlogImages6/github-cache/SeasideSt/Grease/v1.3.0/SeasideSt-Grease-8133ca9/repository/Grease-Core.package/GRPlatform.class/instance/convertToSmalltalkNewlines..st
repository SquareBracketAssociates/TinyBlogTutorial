file library
convertToSmalltalkNewlines: aString
	"Convert any line endings (CR, CRLF, LF) to the default platform newline."
	
	aString isNil 
		ifTrue: [ ^ nil ].
	^ String streamContents: [ :writeStream |
		| readStream |
		readStream := aString readStream.
		[ readStream atEnd ] whileFalse: [
			| next |
			next := readStream next.
			next = Character cr
				ifTrue: [
					readStream peek = Character lf
						ifTrue: [ readStream skip: 1 ].
					writeStream nextPutAll: self newline ]
				ifFalse: [
					next = Character lf
						ifTrue: [ writeStream nextPutAll: self newline ]
						ifFalse: [ writeStream nextPut: next ] ] ] ]