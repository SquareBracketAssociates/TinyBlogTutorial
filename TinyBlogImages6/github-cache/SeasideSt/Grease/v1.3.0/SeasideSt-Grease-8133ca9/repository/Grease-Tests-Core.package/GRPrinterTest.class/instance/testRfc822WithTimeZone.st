tests-timestamp
testRfc822WithTimeZone
	| printer date |
	printer := GRPrinter rfc822WithTimeZone: 'GMT'.
	date := DateAndTime 
		year: 2008
		month: 8
		day: 1
		hour: 9
		minute: 4
		second: 4
		offset: (Duration 
				days: 0
				hours: 0
				minutes: 0
				seconds: 0).
	self assert: (printer print: date) = 'Fri, 01 Aug 2008 09:04:04 GMT'