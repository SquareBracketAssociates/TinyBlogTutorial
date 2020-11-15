convenience
encode: aString
	| writeStream |
	writeStream := self encoderFor: (GRPlatform current
		writeCharacterStreamOn:  (String new: aString size)).
	writeStream nextPutAll: aString.
	^ writeStream contents