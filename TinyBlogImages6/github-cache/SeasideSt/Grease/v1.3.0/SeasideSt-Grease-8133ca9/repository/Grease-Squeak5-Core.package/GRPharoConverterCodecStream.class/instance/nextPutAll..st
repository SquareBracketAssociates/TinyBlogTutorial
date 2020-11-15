streaming
nextPutAll: aString
	aString asString do: [ :each | self nextPut: each ]