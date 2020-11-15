convenience
decode: aString
	| readStream writeStream |
	readStream := self decoderFor: aString readStream.
	writeStream := GRPlatform current writeCharacterStreamOn: (String new: aString size).
	[ readStream atEnd ]
		whileFalse: [ writeStream nextPutAll: (readStream next: 1024) ].
	^ writeStream contents