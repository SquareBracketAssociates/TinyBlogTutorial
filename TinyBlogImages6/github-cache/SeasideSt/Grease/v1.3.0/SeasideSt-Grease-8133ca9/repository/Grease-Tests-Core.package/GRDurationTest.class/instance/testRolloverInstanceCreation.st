tests
testRolloverInstanceCreation
	self assert: (Duration days: 0 hours: 25 minutes: 61 seconds: 61) asMilliseconds = 93721000.
	self assert: (Duration hours: 25) asMilliseconds = 90000000.
	self assert: (Duration minutes: 61) asMilliseconds = 3660000.
	self assert: (Duration seconds: 61) asMilliseconds = 61000.
	self assert: (Duration milliseconds: 1001) asMilliseconds = 1001