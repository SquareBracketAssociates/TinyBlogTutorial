testing
testIntegerConvenienceMethods
	self assert: 5 weeks = (Duration weeks: 5).
	self assert: 5 days = (Duration days: 5).
	self assert: 5 hours = (Duration hours: 5).
	self assert: 5 minutes = (Duration minutes: 5).
	self assert: 5 seconds = (Duration seconds: 5).
	self assert: 5 milliseconds = (Duration milliseconds: 5)