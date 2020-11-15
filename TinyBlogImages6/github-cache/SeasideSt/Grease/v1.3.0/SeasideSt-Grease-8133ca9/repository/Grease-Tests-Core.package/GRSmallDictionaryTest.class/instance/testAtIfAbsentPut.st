tests-accessing
testAtIfAbsentPut
	self assert: (collection at: '1' ifAbsentPut: [ 'foo' ]) = 'foo'.
	self assertAssociations: (Array with: '1' -> 'foo').
	self assert: (collection at: '1' ifAbsentPut: [ 'bar' ]) = 'foo'.
	self assertAssociations: (Array with: '1' -> 'foo')