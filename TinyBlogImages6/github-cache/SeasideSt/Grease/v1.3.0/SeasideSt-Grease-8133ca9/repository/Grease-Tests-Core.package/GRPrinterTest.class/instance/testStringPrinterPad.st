tests
testStringPrinterPad
	| converter |
	converter := GRStringPrinter new.
	converter
		character: $*;
		length: 5.
	converter padLeft.
	self assert: (converter print: 'foo') = '**foo'.
	converter padRight.
	self assert: (converter print: 'foo') = 'foo**'.
	converter padCenter.
	self assert: (converter print: 'foo') = '*foo*'