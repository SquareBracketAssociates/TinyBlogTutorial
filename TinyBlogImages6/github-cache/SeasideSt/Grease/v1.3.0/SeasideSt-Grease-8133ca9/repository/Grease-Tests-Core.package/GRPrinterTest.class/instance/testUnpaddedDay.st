tests-parts-date
testUnpaddedDay
	| printer |
	printer := GRPrinter unpaddedDay.
	self assert: (printer print: (Date year: 2000 month: 1 day: 4)) = '4'.
	self assert: (printer print: (Date year: 2000 month: 1 day: 19)) = '19'