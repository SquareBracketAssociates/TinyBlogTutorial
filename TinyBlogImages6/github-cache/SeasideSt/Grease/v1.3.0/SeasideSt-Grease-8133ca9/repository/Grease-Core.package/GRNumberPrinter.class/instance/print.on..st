printing
print: aNumber on: aStream
	aNumber isNaN
		ifTrue: [ ^ self printNaN: aNumber on: aStream ].
	aNumber isInfinite 
		ifTrue: [ ^ self printInfinite: aNumber on: aStream ].
	precision = 0
		ifTrue: [ self printInteger: aNumber on: aStream ]
		ifFalse: [ self printFloat: aNumber on: aStream ]