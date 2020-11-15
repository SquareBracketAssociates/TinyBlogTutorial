tests
testSorted
	| sorted collection |
	collection := self arbitraryCollection.
	sorted := collection sorted.
	self assert: sorted validSequencedNewResponseFrom: collection.
	self assert: sorted sortedWith: [ :a :b | a <= b ].
	
	sorted := collection sorted: [ :a :b | a > b ].
	self assert: sorted validSequencedNewResponseFrom: collection.
	self assert: sorted sortedWith: [ :a :b | a > b ]