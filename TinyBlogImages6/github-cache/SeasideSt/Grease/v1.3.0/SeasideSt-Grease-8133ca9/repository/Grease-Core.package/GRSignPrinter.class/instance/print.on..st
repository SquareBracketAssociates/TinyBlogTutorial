printing
print: anObject on: aStream 
	anObject negative
		ifTrue: [ negativePrinter print: anObject on: aStream ]
		ifFalse: [ positivePrinter print: anObject on: aStream ]