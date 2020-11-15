tests-parsetree
testParensFormatting
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	class
		compile: 'invalid1
			( 1 + 2)'
		classified: #(accessing).
	class
		compile: 'invalid2
			(1 + 2 )'
		classified: #(accessing).
	self 
		runRule: GRParensFormattingRule
		selectors: #(invalid1 invalid2)