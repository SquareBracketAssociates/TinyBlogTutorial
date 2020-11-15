tests-parts-time
testUnpaddedMinute
	| printer |
	printer := GRPrinter unpaddedMinute.
	self assert: (printer print: (Time hour: 0 minute: 5 second: 0)) = '5'.
	self assert: (printer print: (Time hour: 0 minute: 12 second: 0)) = '12'