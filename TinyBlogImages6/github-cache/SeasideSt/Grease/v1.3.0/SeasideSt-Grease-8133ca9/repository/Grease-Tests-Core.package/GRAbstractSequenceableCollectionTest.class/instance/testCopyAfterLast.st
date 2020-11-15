tests
testCopyAfterLast
	| collection sub |
	
	"match first element"
	collection := self arbitraryCollection.
	sub := collection copyAfterLast: collection last.
	self assert: sub validSequencedNewResponseFrom: collection.
	self assert: sub isEmpty.
	
	"no match"
	self isUnique ifFalse: [
		sub := collection copyAfter: self excludedElement.
		self assert: sub validSequencedNewResponseFrom: collection.
		self assert: sub isEmpty ].
	
	"match an element"
	sub := collection copyAfterLast: self includedElement.
	self assert: sub validSequencedNewResponseFrom: collection.
	self assert: sub = (collection copyFrom: collection size - sub size + 1 to: collection size).
	self assert: (collection at: collection size - sub size) = self includedElement.

	self allowsDuplicateValues ifTrue: [
		sub := collection copyAfterLast: self duplicateElement.
		self assert: sub validSequencedNewResponseFrom: collection.
		self assert: sub = (collection copyFrom: collection size - sub size + 1 to: collection size).
		self assert: (collection at: collection size - sub size) = self duplicateElement.
		self deny: (sub includes: self duplicateElement) ].
	
	"Make sure we're using equality"
	(self isHomogeneous not and: [ self isInitializable ]) ifTrue: [
		collection := self collectionClass withAll: #(1 '1').
		sub := collection copyAfterLast: 1.
		self assert: sub size = 1.
		self assert: (sub at: 1) = '1' ]