private-file-library
asMethodReturningString: aByteArrayOrString named: aSymbol
	"Generates the source of a method named aSymbol that returns aByteArrayOrString as a string."
	^String streamContents: [ :stream |
		stream nextPutAll: aSymbol; nextPut: Character cr.
		stream tab; nextPutAll: '^ '''.
		aByteArrayOrString greaseString do: 
			[ :each | 
			each = $' ifTrue: [ stream nextPut: $' ].
			stream nextPut: each ].
		stream nextPutAll: '''' ]