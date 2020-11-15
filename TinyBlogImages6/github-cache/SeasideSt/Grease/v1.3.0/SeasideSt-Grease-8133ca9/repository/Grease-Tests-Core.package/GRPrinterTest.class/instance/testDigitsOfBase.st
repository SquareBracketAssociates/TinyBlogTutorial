tests-utilites
testDigitsOfBase
	| converter |
	converter := GRNumberPrinter new.
	self assert: (converter 
			digitsOf: 1234
			base: 2) = '10011010010'.
	self assert: (converter 
			digitsOf: 1234
			base: 3) = '1200201'.
	self assert: (converter 
			digitsOf: 1234
			base: 4) = '103102'.
	self assert: (converter 
			digitsOf: 1234
			base: 5) = '14414'.
	self assert: (converter 
			digitsOf: 1234
			base: 6) = '5414'.
	self assert: (converter 
			digitsOf: 1234
			base: 7) = '3412'.
	self assert: (converter 
			digitsOf: 1234
			base: 8) = '2322'.
	self assert: (converter 
			digitsOf: 1234
			base: 9) = '1621'.
	self assert: (converter 
			digitsOf: 1234
			base: 10) = '1234'.
	self assert: (converter 
			digitsOf: 1234
			base: 11) = 'a22'.
	self assert: (converter 
			digitsOf: 1234
			base: 12) = '86a'.
	self assert: (converter 
			digitsOf: 1234
			base: 13) = '73c'.
	self assert: (converter 
			digitsOf: 1234
			base: 14) = '642'.
	self assert: (converter 
			digitsOf: 1234
			base: 15) = '574'.
	self assert: (converter 
			digitsOf: 1234
			base: 16) = '4d2'