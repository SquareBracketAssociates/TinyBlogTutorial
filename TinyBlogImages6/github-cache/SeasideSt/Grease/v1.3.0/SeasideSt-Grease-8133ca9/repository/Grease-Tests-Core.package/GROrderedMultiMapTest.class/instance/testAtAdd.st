tests-accessing
testAtAdd
	collection at: '1' add: 'foo'.
	collection at: '1' add: 'bar'.
	self assertAssociations: (Array with: '1' -> 'foo' with: '1' -> 'bar')