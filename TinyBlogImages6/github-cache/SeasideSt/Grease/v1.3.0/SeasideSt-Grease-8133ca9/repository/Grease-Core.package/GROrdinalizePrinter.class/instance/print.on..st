printing
print: anObject on: aStream
	aStream nextPutAll: (self ordinalize: anObject integerPart)