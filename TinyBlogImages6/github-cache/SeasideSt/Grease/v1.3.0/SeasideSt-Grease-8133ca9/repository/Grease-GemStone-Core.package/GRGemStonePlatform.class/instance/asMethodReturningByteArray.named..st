private-file-library
asMethodReturningByteArray: aByteArrayOrString named: aSymbol
	"Generates the source of a method named aSymbol that returns aByteArrayOrString as a byte array."

	^ String streamContents: [ :stream |
		stream nextPutAll: aSymbol , '

	^#('.
		aByteArrayOrString asByteArray
			do: [ :each | each printOn: stream ]
			separatedBy: [ stream space ].
		stream nextPutAll: ') asByteArray.'; cr.
	].