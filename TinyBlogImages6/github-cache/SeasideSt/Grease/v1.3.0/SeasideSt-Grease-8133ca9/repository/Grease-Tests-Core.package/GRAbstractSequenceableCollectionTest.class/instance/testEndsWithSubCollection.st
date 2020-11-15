tests
testEndsWithSubCollection
	| collection |
	collection := self arbitraryCollection.
	self assert: (collection endsWithSubCollection: (collection copyWithout: collection first)).
	self assert: (collection endsWithSubCollection: collection).
	self deny: (collection endsWithSubCollection: (collection copyWith: collection first))