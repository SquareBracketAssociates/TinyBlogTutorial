tests-parsetree
testUsesClassForHash
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	class
		compile: 'foo
			^ super hash bitXor: self class hash'
		classified: #(accessing).
	class
		compile: 'hash
			^ super hash bitXor: self class hash'
		classified: #(accessing).
	self 
		runRule: GRUsesClassForHashRule
		selectors: #(hash)