tests-block
testNonPortableMessageRule
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.

	self compile: 'invalid1 ^ Array new anyOne' in: class.
	self compile: 'valid1 ^ Array new first' in: class.

	self compile: 'invalid2 ^ Array new withIndexCollect: [ :each :index | each hash ]' in: class.
	self compile: 'valid2 ^ Array new do: [ :each | each hash ]' in: class.

	self 
		runRule: GRNonPortableMessageRule
		selectors: #(invalid1 invalid2)