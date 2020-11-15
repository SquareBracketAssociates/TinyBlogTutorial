tests-block
testBasicNewInitializeMissing
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #Object.
	self compile:  'initialize' in: class.
	self
		runRule: GRBasicNewInitializeMissingRule
		selectors: #(initialize)