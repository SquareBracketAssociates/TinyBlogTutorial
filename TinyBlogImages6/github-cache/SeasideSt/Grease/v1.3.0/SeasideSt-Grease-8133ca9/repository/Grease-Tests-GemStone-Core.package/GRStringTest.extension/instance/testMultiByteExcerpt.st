*grease-tests-gemstone-core
testMultiByteExcerpt
	self assert: ((self multiByteConvert: 'abcde') excerpt: 'c' radius: 0) = '...c...'.
	self assert: ((self multiByteConvert: 'abcde') excerpt: 'c' radius: 1) = '...bcd...'.
	self assert: ((self multiByteConvert: 'abcde') excerpt: 'c' radius: 2) = (self multiByteConvert: 'abcde').
	self assert: ((self multiByteConvert: 'abcde') excerpt: 'c' radius: 3) = (self multiByteConvert: 'abcde').
	
	self assert: ((self multiByteConvert: 'abcde') excerpt: 'c' radius: 0 ellipsis: 'x') = 'xcx'.
	self assert: ((self multiByteConvert: 'abcde') excerpt: 'c' radius: 1 ellipsis: 'x') = 'xbcdx'.
	self assert: ((self multiByteConvert: 'abcde') excerpt: 'c' radius: 2 ellipsis: 'x') = (self multiByteConvert: 'abcde')