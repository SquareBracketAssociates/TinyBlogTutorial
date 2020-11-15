tests
testDateArithmetic
	| today tomorrow oneDay minusOneDay |
	today := DateAndTime year: 2008 month: 9 day: 13 hour: 14 minute: 32 second: 05 offset: Duration zero.
	tomorrow := DateAndTime year: 2008 month: 9 day: 14 hour: 14 minute: 32 second: 05 offset: Duration zero.
	oneDay := Duration days: 1 hours: 0 minutes: 0 seconds: 0.
	minusOneDay := Duration days: -1 hours: 0 minutes: 0 seconds: 0.
	self assert: tomorrow - today = oneDay.
	self assert: today - tomorrow = minusOneDay.
	self assert: today + oneDay = tomorrow.
	self assert: tomorrow - oneDay = today.
	self assert: tomorrow + minusOneDay = today.
	self assert: today - minusOneDay = tomorrow