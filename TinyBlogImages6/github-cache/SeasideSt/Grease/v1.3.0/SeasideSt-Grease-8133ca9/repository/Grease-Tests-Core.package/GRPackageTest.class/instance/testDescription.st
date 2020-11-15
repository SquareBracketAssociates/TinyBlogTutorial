tests
testDescription
	self assert: package description isNil.
	package description: 'A hopeless pacakge'.
	self assert: package description = 'A hopeless pacakge'