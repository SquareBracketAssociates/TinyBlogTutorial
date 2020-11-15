tests
testGreaseIntegerOnNumber
	self assert: 2007 greaseInteger = 2007.
	self assert: 2007.0 greaseInteger = 2007.
	self assert: 2007.1 greaseInteger = 2007.
	self assert: 2007.9 greaseInteger = 2007