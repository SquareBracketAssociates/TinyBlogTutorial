printing
print: anObject on: aStream
	aStream nextPutAll: (block value: anObject)