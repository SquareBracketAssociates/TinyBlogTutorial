testing
testIncludes
	self deny: (collection includes: 0).
	collection add: 0.
	self assert: (collection includes: 0)