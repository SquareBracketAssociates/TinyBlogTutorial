*grease-tests-gemstone-core
testMultiByteTrimBoth
	self assert: (self multiByteConvert: '') trimBoth = ''.
	self assert: (self multiByteConvert: ' ') trimBoth = ''.
	self assert: (self multiByteConvert: '	') trimBoth = ''.
	self assert: (self multiByteConvert: 'foo') trimBoth = 'foo'.
	self assert: (self multiByteConvert: ' foo ') trimBoth = 'foo'.
	self assert: (self multiByteConvert: '  foo  ') trimBoth = 'foo'.
	self assert: ((self collectionClass with: Character cr), '   foo  ') trimBoth = 'foo'.
	
	self assert: ((self multiByteConvert: 'aabbaa') trimBoth: [ :each | each = $a ]) = 'bb'.
	self assert: ((self multiByteConvert: 'bbaabb') trimBoth: [ :each | each = $a ]) = 'bbaabb'