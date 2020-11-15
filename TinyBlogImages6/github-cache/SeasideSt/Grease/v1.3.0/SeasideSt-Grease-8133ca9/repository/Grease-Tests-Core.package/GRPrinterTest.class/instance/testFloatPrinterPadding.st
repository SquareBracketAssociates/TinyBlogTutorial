tests
testFloatPrinterPadding
	| converter |
	converter := GRNumberPrinter new.
	converter digits: 3.
	self assert: (converter print: 1) = '  1'.
	self assert: (converter print: 12) = ' 12'.
	self assert: (converter print: 123) = '123'.
	self assert: (converter print: 1234) = '1234'.
	converter padding: $*.
	self assert: (converter print: 1) = '**1'.
	self assert: (converter print: 12) = '*12'.
	self assert: (converter print: 123) = '123'.
	self assert: (converter print: 1234) = '1234'