tests
testIfNil
	self assert: (nil ifNil: [ 1 ]) = 1.
	self assert: (1 ifNil: [ 2 ]) = 1