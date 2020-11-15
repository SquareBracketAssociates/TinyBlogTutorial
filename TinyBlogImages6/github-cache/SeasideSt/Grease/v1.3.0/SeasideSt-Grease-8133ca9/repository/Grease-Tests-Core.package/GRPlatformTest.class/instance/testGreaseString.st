tests
testGreaseString
	self assert: 'Timberwolf' greaseString = 'Timberwolf'.
	self assert: #DireWolf greaseString = 'DireWolf'.
	self assert: true greaseString = 'true'.
	self assert: 666 greaseString = '666'.
	"make sure we're not immediate"
	self assert: ((2 raisedTo: 64) + 1) greaseString = '18446744073709551617'.
	"make sure we're not immediate"
	self assert: ((2 raisedTo: 64) + 1) negated greaseString = '-18446744073709551617'.
	self assert: $A greaseString = 'A'.
	self assert: nil greaseString = 'nil'.
	[	"Smalltalk/X has constant folding so 1 / 0 will be evaluated at compile time
		resulting in an error when loading the code."
		1 perform: #/ with: 0 ] 
		on: ZeroDivide
		do: [ :error | self assert: error greaseString isString ].
	self assert: 15.25 greaseString = '15.25'.
	self assert: nil greaseString isString.
	self assert: (4 @ 2) greaseString = '4@2'.
	"#greaseString for a byte array should not do any decoding
	this is in place to catch encoding errors early"
	self assert: #(101 97 ) asByteArray greaseString ~= 'ea'.
	self assert: #(101 97 ) asByteArray greaseString isString.
	self assert: Object new greaseString isString.
	"Printing scaled decimals (https://github.com/SeasideSt/Grease/issues/1)"
	self assert: 1.21s3 greaseString = '1.210'.
	self assert: -1.21s3 greaseString = '-1.210'
	