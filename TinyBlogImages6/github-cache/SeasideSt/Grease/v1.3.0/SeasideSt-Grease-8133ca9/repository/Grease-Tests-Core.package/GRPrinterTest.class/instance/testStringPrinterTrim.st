tests
testStringPrinterTrim
	| converter |
	converter := GRStringPrinter new.
	self assert: (converter print: ' foo ') = ' foo '.
	converter trimLeft.
	self assert: (converter print: ' foo ') = 'foo '.
	converter trimRight.
	self assert: (converter print: ' foo ') = ' foo'.
	converter trimBoth.
	self assert: (converter print: ' foo ') = 'foo'