instance-creation
basicForEncoding: aString

	(self supportsEncoding: aString)
		ifFalse: [ ^ self unsupportedEncoding: aString ].
	^self new