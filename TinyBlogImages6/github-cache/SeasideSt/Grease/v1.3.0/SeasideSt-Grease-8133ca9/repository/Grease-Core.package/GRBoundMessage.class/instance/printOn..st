printing
printOn: aStream
	super printOn: aStream.
	aStream nextPutAll: ' arguments: '; print: arguments