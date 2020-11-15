tests-enumerating
testKeysAndAllValuesDo
	| seen |
	collection at: '1' add: 'foo'.
	collection at: '2' add: 'bar'.
	collection at: '1' add: 'zork'.
	seen := OrderedCollection new.
	collection keysAndAllValuesDo: [ :key :values |
		seen add: key -> values ].
	self assert: seen size = 2.
	
	self assert: (seen at: 1) key = '1'.
	self assert: (seen at: 1) value size = 2.
	self assert: ((seen at: 1) value at: 1) = 'foo'.
	self assert: ((seen at: 1) value at: 2) = 'zork'.
	
	self assert: (seen at: 2) key = '2'.
	self assert: (seen at: 2) value size = 1.
	self assert: ((seen at: 2) value at: 1) = 'bar'.