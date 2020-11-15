tests
testFloatPrinterInfinity
	| converter |
	converter := GRNumberPrinter new.
	self assert: (converter print: Float infinity) = 'Infinite'.
	self assert: (converter print: Float infinity negated) = 'Infinite'.
	converter infinite: 'very huge'.
	self assert: (converter print: Float infinity) = 'very huge'.
	self assert: (converter print: Float infinity negated) = 'very huge'