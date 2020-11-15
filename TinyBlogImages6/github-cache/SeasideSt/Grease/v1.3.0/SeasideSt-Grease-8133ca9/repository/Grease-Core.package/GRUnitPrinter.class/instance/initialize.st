initialization
initialize
	super initialize.
	self integerPrinter: (GRNumberPrinter new
		precision: 0;
		yourself).
	self fractionPrinter: (GRNumberPrinter new
		precision: 1;
		yourself)