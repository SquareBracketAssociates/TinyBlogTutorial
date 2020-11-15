tests-parsetree
testTempsFormatting
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	class
		compile: 'invalid1
			| a|'
		classified: #(accessing).
	class
		compile: 'invalid2
			|a |'
		classified: #(accessing).
	class
		compile: 'invalid3
			| a  b |'
		classified: #(accessing).
	self 
		runRule: GRTempsFormattingRule
		selectors: #(invalid1 invalid2 invalid3)