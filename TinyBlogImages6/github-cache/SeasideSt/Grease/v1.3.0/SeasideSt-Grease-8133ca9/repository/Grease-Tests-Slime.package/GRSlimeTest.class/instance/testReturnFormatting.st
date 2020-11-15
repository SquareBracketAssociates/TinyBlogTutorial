tests-parsetree
testReturnFormatting
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	class
		compile: 'invalid1
			^1'
		classified: #(accessing).
	class
		compile: 'invalid2
			^  2'
		classified: #(accessing).
	self 
		runRule: GRReturnFormattingRule
		selectors: #(invalid1 invalid2)