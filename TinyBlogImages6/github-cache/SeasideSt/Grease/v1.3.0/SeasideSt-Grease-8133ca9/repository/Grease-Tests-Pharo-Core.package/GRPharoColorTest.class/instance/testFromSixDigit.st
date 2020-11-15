testing
testFromSixDigit
	self assert: (Color fromString: 'ff0000') = Color red.
	self assert: (Color fromString: 'FF0000') = Color red.
	self assert: (Color fromString: '#ff0000') = Color red.
	self assert: (Color fromString: '#FF0000') = Color red
