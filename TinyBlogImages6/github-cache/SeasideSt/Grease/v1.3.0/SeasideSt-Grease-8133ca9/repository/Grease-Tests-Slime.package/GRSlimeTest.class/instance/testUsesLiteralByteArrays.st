tests-parsetree
testUsesLiteralByteArrays
	| class |
	(self canParse: 'foo #[ 1 2 3 ]')
		ifFalse: [ ^ self ].
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	class
		compile: 'invalid
			^ #[ 1 2 3 ]'
		classified: #(accessing).
	class
		compile: 'valid
			^ ByteArray with: 1 with: 2 with: 3'
		classified: #(accessing).
	self 
		runRule: GRUsesLiteralByteArraysRule
		selectors: #(invalid)