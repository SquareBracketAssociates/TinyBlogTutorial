printing
print: anObject on: aStream
	next print: (block value: anObject) on: aStream