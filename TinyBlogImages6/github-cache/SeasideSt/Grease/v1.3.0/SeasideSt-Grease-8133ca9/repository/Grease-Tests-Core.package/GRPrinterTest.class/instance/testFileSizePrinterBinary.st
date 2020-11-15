tests
testFileSizePrinterBinary
	| converter |
	converter := GRPrinter binaryFileSize.
	self assert: (converter print: 1) = '1 byte'.
	self assert: (converter print: 2) = '2 bytes'.
	self assert: (converter print: 30) = '30 bytes'.
	self assert: (converter print: 500) = '500 bytes'.
	self assert: (converter print: 6000) = '5.9 KiB'.
	self assert: (converter print: 70000) = '68.4 KiB'.
	self assert: (converter print: 800000) = '781.3 KiB'.
	self assert: (converter print: 9000000) = '8.6 MiB'.
	self assert: (converter print: 10000000) = '9.5 MiB'.
	self assert: (converter print: 200000000) = '190.7 MiB'.
	self assert: (converter print: 3000000000) = '2.8 GiB'.
	self assert: (converter print: 40000000000) = '37.3 GiB'