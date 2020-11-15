testing
testRemove
	collection add: 1.
	self assert: (collection remove: 1) = 1.
	self should: [ collection remove: 1 ] raise: Error