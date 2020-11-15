tests-timestamp
testRfc822
	| printer date |
	printer := GRPrinter rfc822.
	date := DateAndTime 
		year: 2008
		month: 8
		day: 1
		hour: 9
		minute: 4
		second: 4
		offset: (Duration 
				days: 0
				hours: -2
				minutes: 0
				seconds: 0).
	self assert: (printer print: date) = 'Fri, 01 Aug 2008 09:04:04 -0200'.
	date := DateAndTime 
		year: 2008
		month: 8
		day: 31
		hour: 19
		minute: 41
		second: 46
		offset: (Duration 
				days: 0
				hours: 0
				minutes: 30
				seconds: 0).
	self assert: (printer print: date) = 'Sun, 31 Aug 2008 19:41:46 +0030'