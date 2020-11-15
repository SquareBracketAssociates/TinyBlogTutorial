tests-utilites
testDigitsOf
	| converter |
	converter := GRNumberPrinter new.
	self assert: (converter 
			digitsOf: 0.0
			base: 10) = '0'.
	self assert: (converter 
			digitsOf: 1.0
			base: 10) = '1'.
	self assert: (converter 
			digitsOf: -1.0
			base: 10) = '1'.
	self assert: (converter 
			digitsOf: -1234567890
			base: 10) = '1234567890'.
	self assert: (converter 
			digitsOf: 1234567890
			base: 10) = '1234567890'.
	self assert: (converter 
			digitsOf: -9876543210
			base: 10) = '9876543210'.
	self assert: (converter 
			digitsOf: 9876543210
			base: 10) = '9876543210'