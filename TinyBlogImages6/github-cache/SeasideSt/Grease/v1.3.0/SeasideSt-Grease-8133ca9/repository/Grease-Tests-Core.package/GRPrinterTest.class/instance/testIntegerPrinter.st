tests
testIntegerPrinter
	| converter |
	converter := GRNumberPrinter new.
	self assert: (converter print: 1234) = '1234'.
	self assert: (converter print: -1234) = '1234'.
	converter separator: $..
	self assert: (converter print: 1234) = '1.234'.
	self assert: (converter print: 1234567) = '1.234.567'.
	converter
		base: 16;
		separator: nil.
	self assert: (converter print: 1234) = '4d2'.
	self assert: (converter print: 123123) = '1e0f3'.
	converter uppercase.
	self assert: (converter print: 1234) = '4D2'.
	self assert: (converter print: 123123) = '1E0F3'