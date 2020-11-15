tests-parts-time
testUnpaddedHour12
	| printer |
	printer := GRPrinter unpaddedHour12.
	self assert: (printer print: (Time hour: 5 minute: 0 second: 0)) = '5'.
	self assert: (printer print: (Time hour: 10 minute: 0 second: 0)) = '10'.
	self assert: (printer print: (Time hour: 14 minute: 0 second: 0)) = '2'.
	self assert: (printer print: (Time hour: 23 minute: 0 second: 0)) = '11'