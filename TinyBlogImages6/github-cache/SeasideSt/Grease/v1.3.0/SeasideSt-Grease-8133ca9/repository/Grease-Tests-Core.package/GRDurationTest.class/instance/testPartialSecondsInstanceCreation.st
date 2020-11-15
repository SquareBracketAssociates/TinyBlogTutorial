tests
testPartialSecondsInstanceCreation
	"ANSI 5.8.3.1 and 5.8.3.2 specify that the seconds argument can be any
	Number - not just an integer as is the case for the other arguments."
	self assert: (Duration days: 0 hours: 0 minutes: 0 seconds: 1.5) asMilliseconds = 1500.
	self assert: (Duration days: 0 hours: 0 minutes: 0 seconds: 3/2) asMilliseconds = 1500.
	self assert: (Duration seconds: 1.5) asMilliseconds = 1500.
	self assert: (Duration seconds: 3/2) asMilliseconds = 1500