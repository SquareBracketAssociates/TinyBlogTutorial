tests
testNegativeInstanceCreation
	self assert: (Duration days: -1 hours: -1 minutes: -1 seconds: -1) asMilliseconds = -90061000.
	self assert: (Duration weeks: -1) asMilliseconds = -604800000.
	self assert: (Duration days: -1) asMilliseconds = -86400000.
	self assert: (Duration hours: -1) asMilliseconds = -3600000.
	self assert: (Duration minutes: -1) asMilliseconds = -60000.
	self assert: (Duration seconds: -1) asMilliseconds = -1000.
	self assert: (Duration milliseconds: -1) asMilliseconds = -1