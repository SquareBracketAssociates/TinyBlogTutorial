tests-transform
testAnsiCharacterRule
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	self compile: 'character Character value: 123' in: class.
	self compile: 'characterRange $a to: $c' in: class.
	self 
		runTransformation: GRAnsiCharactersRule
		changes: #('character Character codePoint: 123' 'characterRange ''abc''')