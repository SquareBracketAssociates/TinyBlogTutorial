tests-parts-date
testUnpaddedYear
	| printer |
	printer := GRPrinter unpaddedYear.
	self assert: (printer print: (Date year: 766 month: 1 day: 1)) = '766'.
	self assert: (printer print: (Date year: 1980 month: 1 day: 1)) = '1980'.
	self assert: (printer print: (Date year: 2009 month: 1 day: 1)) = '2009'