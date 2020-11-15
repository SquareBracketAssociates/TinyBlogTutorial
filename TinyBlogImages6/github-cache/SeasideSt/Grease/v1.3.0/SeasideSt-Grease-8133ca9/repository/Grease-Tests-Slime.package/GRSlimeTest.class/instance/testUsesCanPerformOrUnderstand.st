tests-parsetree
testUsesCanPerformOrUnderstand
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	class
		compile: 'invalid1
			Object class canUnderstand: #new'
		classified: #(accessing).
	class
		compile: 'invalid2
			Object class canPerform: #new'
		classified: #(accessing).
	class
		compile: 'valid
			Object respondsTo: #new'
		classified: #(accessing).
	self 
		runRule: GRUsesCanPerformOrUnderstandRule
		selectors: #(invalid1 invalid2)