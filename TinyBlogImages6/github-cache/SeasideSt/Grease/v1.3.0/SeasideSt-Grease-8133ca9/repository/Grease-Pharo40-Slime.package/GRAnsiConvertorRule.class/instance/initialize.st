initialization
initialize
	super initialize.
	self rewriteRule
		replace: '``@object asString' with: '``@object greaseString';
		replace: '``@object asInteger' with: '``@object greaseInteger'