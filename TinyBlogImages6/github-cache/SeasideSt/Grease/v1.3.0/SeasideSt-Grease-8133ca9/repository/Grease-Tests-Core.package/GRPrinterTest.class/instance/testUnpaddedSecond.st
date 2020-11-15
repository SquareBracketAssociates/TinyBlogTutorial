tests-parts-time
testUnpaddedSecond
	| printer |
	printer := GRPrinter unpaddedSecond.
	self assert: (printer print: (Time hour: 0 minute: 0 second: 0)) = '0'.
	self assert: (printer print: (Time hour: 0 minute: 0 second: 9)) = '9'.
	self assert: (printer print: (Time hour: 0 minute: 0 second: 12)) = '12'