tests
testSort
	| collection |
	self isSequenced ifFalse: [ ^ self ].
	
	collection := self arbitraryCollection.
	collection sort.
	self assert: collection sortedWith: [ :a :b | a <= b ].
	
	collection sort: [ :a :b | a > b ].
	self assert: collection sortedWith: [ :a :b | a > b ]