tests
testEmptyAny
	| collection |
	collection := self emptyCollection.
	
	self should: [ (self valuesOf: collection) includes: collection any ] raise: Error