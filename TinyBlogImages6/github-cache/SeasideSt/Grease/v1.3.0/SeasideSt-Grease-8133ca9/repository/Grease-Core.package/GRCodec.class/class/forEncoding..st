instance creation
forEncoding: aString
	"Answer a new codec instance for the given encoding name. Raise an WAUnsupportedEncodingError if the encoding name is not supported by this image."

	self allSubclassesDo: [ :each | 
		(each supportsEncoding: aString)
			ifTrue: [ ^ each basicForEncoding: aString ] ].
	^ self unsupportedEncoding: aString