tests
testFloatPrinter
	| converter |
	converter := GRNumberPrinter new precision: 2.
	self assert: (converter print: 1.009) = '1.01'.
	self assert: (converter print: 1.01) = '1.01'.
	self assert: (converter print: 1.019) = '1.02'.
	self assert: (converter print: 1.25) = '1.25'.
	self assert: (converter print: 1.254) = '1.25'.
	self assert: (converter print: 1.256) = '1.26'.
	self assert: (converter print: 1.009) = '1.01'.
	self assert: (converter print: 0.9) = '0.90'.
	self assert: (converter print: 0.99) = '0.99'.
	self assert: (converter print: 0.999) = '1.00'.
	self assert: (converter print: 0.9999) = '1.00'.
	self assert: (converter print: -0.9) = '0.90'.
	self assert: (converter print: -0.99) = '0.99'.
	self assert: (converter print: -0.999) = '1.00'.
	self assert: (converter print: -0.9999) = '1.00'