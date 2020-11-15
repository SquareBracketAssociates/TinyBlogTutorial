tests-accessing
testAtPut
	collection at: '1' put: 'foo'.
	collection at: '2' put: 'bar'.
	self assertAssociations: (Array with: '1' -> 'foo' with: '2' -> 'bar').
	collection at: '1' put: 'baz'.
	self assertAssociations: (Array with: '1' -> 'baz' with: '2' -> 'bar')