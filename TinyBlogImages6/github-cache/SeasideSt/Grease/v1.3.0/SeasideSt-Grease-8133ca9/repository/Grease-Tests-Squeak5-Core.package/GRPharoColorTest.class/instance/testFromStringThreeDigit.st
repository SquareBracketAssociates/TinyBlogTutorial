testing
testFromStringThreeDigit
	self assert: (Color fromString: 'f00') = Color red.
	self assert: (Color fromString: 'F00') = Color red.
	self assert: (Color fromString: '#f00') = Color red.
	self assert: (Color fromString: '#F00') = Color red