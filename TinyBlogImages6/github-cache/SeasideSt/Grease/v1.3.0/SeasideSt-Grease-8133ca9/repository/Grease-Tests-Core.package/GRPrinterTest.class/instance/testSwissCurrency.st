tests-currency
testSwissCurrency
	| printer |
	printer := GRPrinter swissCurrency.
	self assert: (printer print: 12.34) = 'CHF 12.35'.
	self assert: (printer print: -12.39) = 'CHF -12.40'