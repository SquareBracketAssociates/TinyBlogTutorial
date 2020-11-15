tests-parts-time
testPaddedHour12
	| printer |
	printer := GRPrinter paddedHour12.
	self assert: (printer print: (Time hour: 5 minute: 0 second: 0)) = '05'.
	self assert: (printer print: (Time hour: 10 minute: 0 second: 0)) = '10'.
	self assert: (printer print: (Time hour: 14 minute: 0 second: 0)) = '02'.
	self assert: (printer print: (Time hour: 23 minute: 0 second: 0)) = '11'