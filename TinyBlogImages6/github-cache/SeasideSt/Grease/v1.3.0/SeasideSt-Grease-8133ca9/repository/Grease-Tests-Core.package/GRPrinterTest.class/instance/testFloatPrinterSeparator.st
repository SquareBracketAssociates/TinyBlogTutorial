tests
testFloatPrinterSeparator
	| converter |
	converter := GRNumberPrinter new.
	converter
		precision: 2;
		separator: $*.
	self assert: (converter print: 12345.0) = '12*345.00'.
	self assert: (converter print: 0.6789) = '0.68'.
	converter
		precision: 4;
		separator: $!.
	self assert: (converter print: 12345.0) = '12!345.000!0'.
	self assert: (converter print: 0.6789) = '0.678!9'