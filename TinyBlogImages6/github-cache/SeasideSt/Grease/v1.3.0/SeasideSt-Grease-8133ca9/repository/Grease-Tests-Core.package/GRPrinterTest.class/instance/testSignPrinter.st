tests
testSignPrinter
	| converter |
	converter := GRSignPrinter new.
	converter
		negativePrinter: $-;
		positivePrinter: $+.
	self assert: (converter print: 12) = '+'.
	self assert: (converter print: -12) = '-'