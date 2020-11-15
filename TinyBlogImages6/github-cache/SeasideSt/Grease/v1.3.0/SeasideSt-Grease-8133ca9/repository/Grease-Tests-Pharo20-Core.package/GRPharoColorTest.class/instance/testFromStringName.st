testing
testFromStringName
	self assert: (Color fromString: 'red') = Color red.
	self assert: (Color fromString: 'RED') = Color red.
	self assert: (Color fromString: '#red') = Color red.
	self assert: (Color fromString: '#RED') = Color red
