tests-block
testNonPortableSourceFormat
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	self compile: 'invalid ^ ''Unicode snow man', (String with: (Character codePoint: 16r2603)) , '''' in: class.
	self compile: 'valid ^ ''everything is fine''' in: class.
	self 
		runRule: GRNonPortableSourceFormatRule
		selectors: #(invalid)