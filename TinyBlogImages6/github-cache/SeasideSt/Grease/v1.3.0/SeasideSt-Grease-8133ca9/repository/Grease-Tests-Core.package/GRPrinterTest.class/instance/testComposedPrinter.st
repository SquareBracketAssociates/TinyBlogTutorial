tests
testComposedPrinter
	| converter |
	converter := GRSequentialPrinter new , 'CHF ' , GRNumberPrinter new.
	self assert: (converter print: 1234) = 'CHF 1234'.
	self assert: (converter print: -1234) = 'CHF 1234'.
	converter := GRSignPrinter new , GRNumberPrinter new , '%'.
	self assert: (converter print: 1234) = '1234%'.
	self assert: (converter print: -1234) = '-1234%'