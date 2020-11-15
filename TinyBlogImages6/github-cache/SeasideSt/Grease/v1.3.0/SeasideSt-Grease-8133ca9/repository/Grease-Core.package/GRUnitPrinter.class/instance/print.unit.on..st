printing
print: aNumber unit: aString on: aStream
	(units first = aString or: [ units second = aString ])
		ifTrue: [ integerPrinter print: aNumber on: aStream ]
		ifFalse: [ fractionPrinter print: aNumber on: aStream ].
	aStream nextPut: $ ; nextPutAll: aString