streaming
nextPutAll: aString
	stream nextPutAll: aString.
	count := count + aString size
	