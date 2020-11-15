tests-excerpt
testExcerptRight
	self assert: ('abcde' excerpt: 'b' radius: 0 ellipsis: 'x') = 'xbx'.
	self assert: ('abcde' excerpt: 'b' radius: 1 ellipsis: 'x') = 'abcx'.
	self assert: ('abcde' excerpt: 'b' radius: 2 ellipsis: 'x') = 'abcdx'.
	self assert: ('abcde' excerpt: 'b' radius: 3 ellipsis: 'x') = 'abcde'