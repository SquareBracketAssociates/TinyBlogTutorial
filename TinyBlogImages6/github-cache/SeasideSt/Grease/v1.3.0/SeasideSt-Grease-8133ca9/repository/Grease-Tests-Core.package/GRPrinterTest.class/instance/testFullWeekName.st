tests-parts-date
testFullWeekName
	| printer |
	printer := GRPrinter fullWeekName.
	self assert: (printer print: (Date year: 1980 month: 1 day: 1)) = 'Tuesday'.
	self assert: (printer print: (Date year: 2000 month: 1 day: 1)) = 'Saturday'