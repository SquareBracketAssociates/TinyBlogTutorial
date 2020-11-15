testing
testCopy
	| copy |
	collection add: 1.
	copy := collection copy.
	collection add: 2.
	
	self assert: collection size = 2.
	self assert: copy size = 1.
	
	self assert: (collection includes: 2).
	self deny: (copy includes: 2).