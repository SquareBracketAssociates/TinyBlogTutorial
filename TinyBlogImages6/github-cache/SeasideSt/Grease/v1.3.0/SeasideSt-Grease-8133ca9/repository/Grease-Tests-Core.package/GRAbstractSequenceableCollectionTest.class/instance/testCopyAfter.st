tests
testCopyAfter
	| collection sub |
	
	"match last element"
	collection := self arbitraryCollection.
	sub := collection copyAfter: collection last.
	self assert: sub validSequencedNewResponseFrom: collection.
	self assert: sub isEmpty.
	
	"no match"
	self isUnique ifFalse: [
		sub := collection copyAfter: self excludedElement.
		self assert: sub validSequencedNewResponseFrom: collection.
		self assert: sub isEmpty ].
	
	"match an element"
	sub := collection copyAfter: self includedElement.
	self assert: sub validSequencedNewResponseFrom: collection.
	self assert: sub = (collection copyFrom: collection size - sub size + 1 to: collection size).
	self assert: (collection at: collection size - sub size) = self includedElement.

	self allowsDuplicateValues ifTrue: [
		sub := collection copyAfter: self duplicateElement.
		self assert: sub validSequencedNewResponseFrom: collection.
		self assert: sub = (collection copyFrom: collection size - sub size + 1 to: collection size).
		self assert: (collection at: collection size - sub size) = self duplicateElement.
		self assert: (sub includes: self duplicateElement) ].
	
	"Make sure we're using equality"
	(self isHomogeneous not and: [ self isInitializable ]) ifTrue: [
		collection := self collectionClass withAll: #(1 '1').
		sub := collection copyAfter: 1.
		self assert: sub size = 1.
		self assert: (sub at: 1) = '1' ]