tests-parts-date
testUnpaddedMonth
	| printer |
	printer := GRPrinter unpaddedMonth.
	self assert: (printer print: (Date year: 2000 month: 8 day: 1)) = '8'.
	self assert: (printer print: (Date year: 2000 month: 11 day: 1)) = '11'