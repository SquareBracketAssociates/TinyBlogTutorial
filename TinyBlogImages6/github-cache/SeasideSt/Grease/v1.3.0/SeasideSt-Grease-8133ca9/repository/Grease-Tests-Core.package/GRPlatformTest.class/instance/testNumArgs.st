tests
testNumArgs
	self assert: #not numArgs isZero.
	self assert: #+ numArgs = 1.
	self assert: #and: numArgs = 1.
	self assert: #value:value: numArgs = 2