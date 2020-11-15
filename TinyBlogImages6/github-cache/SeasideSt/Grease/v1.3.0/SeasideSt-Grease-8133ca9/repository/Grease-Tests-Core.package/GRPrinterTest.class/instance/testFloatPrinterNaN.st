tests
testFloatPrinterNaN
	| converter |
	converter := GRNumberPrinter new.
	self assert: (converter print: Float nan) = 'NaN'.
	converter nan: 'Not A Number'.
	self assert: (converter print: Float nan) = 'Not A Number'