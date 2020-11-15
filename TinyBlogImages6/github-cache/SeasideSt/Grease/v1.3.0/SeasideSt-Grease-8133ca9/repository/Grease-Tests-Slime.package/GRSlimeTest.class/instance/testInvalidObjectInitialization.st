tests-block
testInvalidObjectInitialization
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	self compile:  'initializeFoo: aNumber' in: class.
	self 
		runRule: GRInvalidObjectInitializationRule
		selectors: #(initializeFoo:)