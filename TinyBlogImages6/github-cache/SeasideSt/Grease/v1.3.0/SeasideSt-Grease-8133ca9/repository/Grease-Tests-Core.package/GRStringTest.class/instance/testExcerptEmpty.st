tests-excerpt
testExcerptEmpty
	self assert: ('' excerpt: '') isNil.
	self assert: ('' excerpt: 'x') isNil.
	self assert: ('x' excerpt: '') isNil