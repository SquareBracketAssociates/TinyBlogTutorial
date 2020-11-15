tests
testMixedInstanceCreation
	self assert: (Duration days: 1 hours: -23 minutes: 1 seconds: -59) asMilliseconds = 3601000
