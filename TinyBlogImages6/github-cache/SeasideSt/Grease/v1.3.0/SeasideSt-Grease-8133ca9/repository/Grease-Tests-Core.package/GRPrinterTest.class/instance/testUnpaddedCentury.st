tests-parts-date
testUnpaddedCentury
	| printer |
	printer := GRPrinter unpaddedCentury.
	self assert: (printer print: (Date year: 1980 month: 1 day: 1)) = '80'.
	self assert: (printer print: (Date year: 2009 month: 1 day: 1)) = '9'