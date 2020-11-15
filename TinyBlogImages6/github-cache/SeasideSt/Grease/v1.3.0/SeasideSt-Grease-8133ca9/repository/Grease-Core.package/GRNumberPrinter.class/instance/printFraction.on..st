printing
printFraction: aNumber on: aStream
	| result |
	result := self
		pad: (self digitsOf: aNumber rounded base: base)
		left: $0 to: precision.
	separator isNil
		ifFalse: [ result := self separate: result left: separator ].
	aStream nextPutAll: result