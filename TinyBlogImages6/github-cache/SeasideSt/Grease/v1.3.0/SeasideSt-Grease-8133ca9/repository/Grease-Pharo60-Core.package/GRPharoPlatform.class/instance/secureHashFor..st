cryptography
secureHashFor: aString
	^ SHA1 new hashMessage: aString