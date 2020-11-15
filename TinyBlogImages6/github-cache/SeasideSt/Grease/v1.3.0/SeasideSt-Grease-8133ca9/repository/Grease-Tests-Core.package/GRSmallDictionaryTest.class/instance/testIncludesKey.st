tests-testing
testIncludesKey
	self deny: (collection includesKey: '1').
	collection add: '1' -> 'foo'.
	collection add: '1' -> 'bar'.
	self assert: (collection includesKey: '1')