tests
testZero
	| duration |
	duration := Duration zero.
	self assert: duration isZero.
	self assert: duration asMilliseconds = 0.
	self assert: duration = (Duration seconds: 0)