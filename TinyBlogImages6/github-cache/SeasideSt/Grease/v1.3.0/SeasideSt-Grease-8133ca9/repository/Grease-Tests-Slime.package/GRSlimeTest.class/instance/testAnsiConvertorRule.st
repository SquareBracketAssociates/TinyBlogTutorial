tests-transform
testAnsiConvertorRule
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	self compile: 'convertInteger ''1'' asInteger' in: class.
	self compile: 'convertString 2 asString' in: class.
	self 
		runTransformation: GRAnsiConvertorRule
		changes: #( 
			'convertInteger ''1'' greaseInteger'
			'convertString 2 greaseString' )