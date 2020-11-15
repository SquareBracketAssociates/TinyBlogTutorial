tests
testAllCodesIncludesIso88591
	self assert: (GRCodec allCodecs anySatisfy: [ :each |
		each name = 'iso-8859-1' ])