tests-timestamp
testHttp
	| printer date offsetHour |
	offsetHour := 2.
	printer := GRPrinter httpDate.
	date := DateAndTime 
		year: 1994
		month: 11
		day: 6
		hour: 8 + offsetHour
		minute: 49
		second: 37
		offset: (Duration 
				days: 0
				hours: offsetHour
				minutes: 0
				seconds: 0).
	self assert: (printer print: date) = 'Sun, 06 Nov 1994 08:49:37 GMT'