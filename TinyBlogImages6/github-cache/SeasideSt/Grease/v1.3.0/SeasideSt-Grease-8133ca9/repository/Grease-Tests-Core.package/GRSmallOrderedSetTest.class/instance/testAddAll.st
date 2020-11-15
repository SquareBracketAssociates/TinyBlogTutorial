testing
testAddAll
	collection addAll: #(2 1 1).
	self assert: collection size = 2.
	self assert: (collection includes: 1).
	self assert: (collection includes: 2)