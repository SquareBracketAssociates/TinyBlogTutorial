tests-block
testUsesNotPortableClass
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	self compile: 'invalid ^ Semaphore new' in: class.
	self compile: 'valid ^ GRObject new' in: class.
	self 
		runRule: GRUsesNotPortableClassRule
		selectors: #(invalid)