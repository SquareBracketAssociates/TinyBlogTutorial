tests
testAccessors
	| duration |
	duration := Duration seconds: 356521.
	self assert: duration days = 4.
	self assert: duration hours = 3.
	self assert: duration minutes = 2.
	self assert: duration seconds = 1.
	self assert: duration milliseconds = 0