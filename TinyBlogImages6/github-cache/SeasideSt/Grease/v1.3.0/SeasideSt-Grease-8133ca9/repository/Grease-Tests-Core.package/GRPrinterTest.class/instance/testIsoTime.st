tests-timestamp
testIsoTime
	| printer |
	printer := GRPrinter isoTime.
	self assert: (printer print: (Time 
				hour: 0
				minute: 0
				second: 0)) = '00:00:00'.
	self assert: (printer print: (Time 
				hour: 1
				minute: 2
				second: 3)) = '01:02:03'.
	self assert: (printer print: (Time 
				hour: 12
				minute: 23
				second: 34)) = '12:23:34'