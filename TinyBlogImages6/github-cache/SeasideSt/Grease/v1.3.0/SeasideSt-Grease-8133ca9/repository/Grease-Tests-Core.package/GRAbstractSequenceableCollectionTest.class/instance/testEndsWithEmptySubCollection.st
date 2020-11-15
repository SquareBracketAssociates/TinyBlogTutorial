tests
testEndsWithEmptySubCollection
	| collection | 
	collection := self arbitraryCollection.
	self deny: (collection endsWithSubCollection: self emptyCollection).
	self deny: (self emptyCollection endsWithSubCollection: collection)