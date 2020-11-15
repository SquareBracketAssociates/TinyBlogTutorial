tests
testStringPrinterLength
	| converter |
	converter := GRStringPrinter new.
	self assert: (converter print: 'foo') = 'foo'.
	converter length: 3.
	self assert: (converter print: 'foo') = 'foo'.
	converter length: 1.
	self assert: (converter print: 'foo') = 'f'