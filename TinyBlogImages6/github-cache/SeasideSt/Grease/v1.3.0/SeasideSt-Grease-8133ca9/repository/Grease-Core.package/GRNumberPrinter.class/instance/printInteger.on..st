printing
printInteger: aNumber on: aStream
	| result |
	result := self digitsOf: aNumber integerPart base: base.
	separator isNil
		ifFalse: [ result := self separate: result right: separator ].
	(digits isNil or: [ padding isNil ])
		ifFalse: [ result := self pad: result left: padding to: digits ].
	aStream nextPutAll: result