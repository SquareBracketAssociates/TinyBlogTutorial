tests-currency
testUsCurrency
	| printer |
	printer := GRPrinter usCurrency.
	self assert: (printer print: 12.34) = '$12.34'.
	self assert: (printer print: -12.34) = '-$12.34'