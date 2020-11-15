tests
testConversions
	| duration |
	duration := Duration days: 4 hours: 3 minutes: 2 seconds: 1.
	self assert: duration asSeconds = 356521.
	self assert: duration asMilliseconds = 356521000.
	self assert: duration negated asSeconds = -356521.
	self assert: duration negated asMilliseconds = -356521000
	