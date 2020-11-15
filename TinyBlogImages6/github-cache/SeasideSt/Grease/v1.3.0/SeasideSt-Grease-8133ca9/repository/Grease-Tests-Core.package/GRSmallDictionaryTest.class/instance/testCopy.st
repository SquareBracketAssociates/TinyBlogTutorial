tests
testCopy
	| other |
	collection at: 1 put: 'foo'; at: 2 put: 'bar'.
	other := collection copy.
	collection at: 1 put: 'zork'; at: 3 put: 'zonk'.
	other at: 2 put: 'other'.
	
	self assert: collection size = 3.
	self assert: (collection at: 1) = 'zork'.
	self assert: (collection at: 2) = 'bar'.
	self assert: (collection at: 3) = 'zonk'.
	
	self assert: other size = 2.
	self assert: (other at: 1) = 'foo'.
	self assert: (other at: 2) = 'other'