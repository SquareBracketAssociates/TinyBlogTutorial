tests-parts-date
testFullMonthName
	| printer |
	printer := GRPrinter fullMonthName.
	self assert: (printer print: (Date year: 2000 month: 8 day: 1)) = 'August'.
	self assert: (printer print: (Date year: 2000 month: 11 day: 1)) = 'November'