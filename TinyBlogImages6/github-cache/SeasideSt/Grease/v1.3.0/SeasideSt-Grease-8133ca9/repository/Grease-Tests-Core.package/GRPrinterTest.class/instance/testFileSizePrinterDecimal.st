tests
testFileSizePrinterDecimal
	| converter |
	converter := GRPrinter decimalFileSize.
	self assert: (converter print: 1) = '1 byte'.
	self assert: (converter print: 2) = '2 bytes'.
	self assert: (converter print: 30) = '30 bytes'.
	self assert: (converter print: 500) = '500 bytes'.
	self assert: (converter print: 6000) = '6.0 kB'.
	self assert: (converter print: 70000) = '70.0 kB'.
	self assert: (converter print: 800000) = '800.0 kB'.
	self assert: (converter print: 9000000) = '9.0 MB'.
	self assert: (converter print: 10000000) = '10.0 MB'.
	self assert: (converter print: 200000000) = '200.0 MB'.
	self assert: (converter print: 3000000000) = '3.0 GB'.
	self assert: (converter print: 40000000000) = '40.0 GB'