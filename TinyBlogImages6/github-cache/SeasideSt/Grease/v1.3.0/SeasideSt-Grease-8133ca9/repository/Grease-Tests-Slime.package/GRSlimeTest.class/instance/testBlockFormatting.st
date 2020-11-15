tests-parsetree
testBlockFormatting
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	class
		compile: 'invalid1
			[:a ]'
		classified: #(accessing).
	class
		compile: 'invalid2
			[:a | ]'
		classified: #(accessing).
	class
		compile: 'invalid3
			[ :b]'
		classified: #(accessing).
	
	class
		compile: 'invalid4
			[ :a| ]'
		classified: #(accessing).
	class
		compile: 'invalid5
			[ :a |a ]'
		classified: #(accessing).
	self 
		runRule: GRBlockFormattingRule
		selectors: #(invalid1 invalid2 invalid3 invalid4 invalid5)