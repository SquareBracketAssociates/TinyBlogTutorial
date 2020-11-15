tests-testing
testIsEmpty
	self assert: collection isEmpty.
	collection add: '1' -> 'foo'.
	collection add: '1' -> 'bar'.
	self deny: collection isEmpty