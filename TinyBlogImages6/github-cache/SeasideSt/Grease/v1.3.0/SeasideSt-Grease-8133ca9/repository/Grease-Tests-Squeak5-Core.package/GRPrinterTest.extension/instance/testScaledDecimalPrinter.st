*grease-tests-squeak5-core
testScaledDecimalPrinter
	| converter |
	converter := GRNumberPrinter new precision: 2.
	self assert: (converter print: 1.009s3) = '1.01'.
	self assert: (converter print: 1.01s2) = '1.01'.
	self assert: (converter print: 1.019s3) = '1.02'.
	self assert: (converter print: 1.25s2) = '1.25'.
	self assert: (converter print: 1.254s3) = '1.25'.
	self assert: (converter print: 1.256s3) = '1.26'.
	self assert: (converter print: 1.009s3) = '1.01'.
	self assert: (converter print: 0.9s1) = '0.90'.
	self assert: (converter print: 0.99s2) = '0.99'.
	self assert: (converter print: 0.999s3) = '1.00'.
	self assert: (converter print: 0.9999s4) = '1.00'.
	self assert: (converter print: -0.9s1) = '0.90'.
	self assert: (converter print: -0.99s2) = '0.99'.
	self assert: (converter print: -0.999s3) = '1.00'.
	self assert: (converter print: -0.9999s4) = '1.00'