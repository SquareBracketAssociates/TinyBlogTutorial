tests
testBeginsWithEmptySubCollection
	| collection | 
	collection := self arbitraryCollection.
	self deny: (collection beginsWithSubCollection: self emptyCollection).
	self deny: (self emptyCollection beginsWithSubCollection: collection)