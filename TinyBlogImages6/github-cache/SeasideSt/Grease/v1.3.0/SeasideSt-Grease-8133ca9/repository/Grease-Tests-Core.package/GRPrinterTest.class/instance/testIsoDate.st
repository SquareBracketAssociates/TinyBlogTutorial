tests-timestamp
testIsoDate
	| printer |
	printer := GRPrinter isoDate.
	self assert: (printer print: (Date 
				year: 1980
				month: 6
				day: 11)) = '1980-06-11'.
	self assert: (printer print: (Date 
				year: 2003
				month: 12
				day: 1)) = '2003-12-01'.
	self assert: (printer print: (Date 
				year: 800
				month: 12
				day: 24)) = '0800-12-24'