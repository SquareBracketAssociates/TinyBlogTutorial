tests
testName
	self assert: package name isNil.
	package name: 'Gimme-Hope'.
	self assert: package name = 'Gimme-Hope'