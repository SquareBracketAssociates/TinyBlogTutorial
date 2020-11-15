tests-truncate
testTruncate
	self assert: ('abc' truncate) = 'abc'.
	self assert: ('abc' truncate: 3) = 'abc'.
	self assert: ('abc' truncate: 2) = 'ab...'.
	
	self assert: ('abc' truncate: 1 ellipsis: '') = 'a'.
	self assert: ('abc' truncate: 0 ellipsis: 'none') = 'none'