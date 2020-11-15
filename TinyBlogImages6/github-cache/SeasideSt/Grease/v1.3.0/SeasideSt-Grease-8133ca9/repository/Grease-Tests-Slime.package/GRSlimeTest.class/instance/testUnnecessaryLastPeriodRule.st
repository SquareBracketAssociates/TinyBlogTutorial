tests-block
testUnnecessaryLastPeriodRule
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	self compile: 'invalid 1. 2.' in: class.
	self compile: 'valid 1. 2' in: class.
	self 
		runRule: GRUnnecessaryLastPeriodRule
		selectors: #(invalid)