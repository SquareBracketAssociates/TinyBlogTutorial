tests
testAddFirst
	| collection |
	(self isExtensible and: [ self isSequenced ]) ifFalse: [ ^ self ].
	
	collection := self arbitraryCollection.
	collection addFirst: self excludedElement.
	self assert: (collection at: 1) = self excludedElement.
	self assert: (collection copyFrom: 2 to: collection size) = self arbitraryCollection