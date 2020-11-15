tests-block
testUsesMethodAnnotations
	| class |
	(self canParse: 'foo <foo: 123>')
		ifFalse: [ ^ self ].
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	self compile: 'invalid <foo: 123>' in: class.
	self compile: 'valid' in: class.
	self 
		runRule: GRUsesMethodAnnotationsRule
		selectors: #(invalid)