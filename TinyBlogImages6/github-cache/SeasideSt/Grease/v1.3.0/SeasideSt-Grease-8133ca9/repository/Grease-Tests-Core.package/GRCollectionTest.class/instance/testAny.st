tests
testAny
	| collection |
	collection := self arbitraryCollection.
	
	self assert: ((self valuesOf: collection) includes: collection any)