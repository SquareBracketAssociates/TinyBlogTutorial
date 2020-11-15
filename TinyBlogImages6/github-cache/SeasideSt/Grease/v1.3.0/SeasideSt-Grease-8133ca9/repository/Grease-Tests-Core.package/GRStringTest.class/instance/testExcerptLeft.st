tests-excerpt
testExcerptLeft
	self assert: ('abcde' excerpt: 'd' radius: 0 ellipsis: 'x') = 'xdx'.
	self assert: ('abcde' excerpt: 'd' radius: 1 ellipsis: 'x') = 'xcde'.
	self assert: ('abcde' excerpt: 'd' radius: 2 ellipsis: 'x') = 'xbcde'.
	self assert: ('abcde' excerpt: 'd' radius: 3 ellipsis: 'x') = 'abcde'