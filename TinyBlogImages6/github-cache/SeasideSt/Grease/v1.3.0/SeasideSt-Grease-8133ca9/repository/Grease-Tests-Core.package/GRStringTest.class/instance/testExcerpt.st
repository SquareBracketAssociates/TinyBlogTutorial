tests-excerpt
testExcerpt
	self assert: ('abcde' excerpt: 'c' radius: 0) = '...c...'.
	self assert: ('abcde' excerpt: 'c' radius: 1) = '...bcd...'.
	self assert: ('abcde' excerpt: 'c' radius: 2) = 'abcde'.
	self assert: ('abcde' excerpt: 'c' radius: 3) = 'abcde'.
	
	self assert: ('abcde' excerpt: 'c' radius: 0 ellipsis: 'x') = 'xcx'.
	self assert: ('abcde' excerpt: 'c' radius: 1 ellipsis: 'x') = 'xbcdx'.
	self assert: ('abcde' excerpt: 'c' radius: 2 ellipsis: 'x') = 'abcde'