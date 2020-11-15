tests-parsetree
testUsesCurlyBraceArrays
	| class |
	(self canParse: 'foo { self foo. self bar }')
		ifFalse: [ ^ self ].
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	class
		compile: 'invalid
			^ { self foo. self bar }'
		classified: #(accessing).
	class
		compile: 'valid
			^ Array new'
		classified: #(accessing).
	self 
		runRule: GRUsesCurlyBraceArraysRule
		selectors: #(invalid)