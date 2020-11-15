printing
printFloat: aNumber on: aStream
	| multiplier rounded |
	multiplier := base raisedTo: precision.
	rounded := aNumber roundTo: (accuracy ifNil: [ multiplier reciprocal ]).
	self printInteger: rounded on: aStream.
	delimiter isNil
		ifFalse: [ aStream nextPut: delimiter ].
	self printFraction: rounded fractionPart abs * multiplier on: aStream