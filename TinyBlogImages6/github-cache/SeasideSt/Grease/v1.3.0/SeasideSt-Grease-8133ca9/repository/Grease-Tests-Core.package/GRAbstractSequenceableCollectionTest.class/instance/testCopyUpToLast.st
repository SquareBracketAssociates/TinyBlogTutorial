tests
testCopyUpToLast
	| collection sub |
	
	"match first element"
	collection := self arbitraryCollection.
	sub := collection copyUpToLast: collection first.
	self assert: sub validSequencedNewResponseFrom: collection.
	self assert: sub isEmpty.
	
	"no match"
	self isUnique ifFalse: [
		sub := collection copyUpToLast: self excludedElement.
		self assert: sub validSequencedNewResponseFrom: collection.
		self assert: sub size = collection size.
		collection keysAndValuesDo: [ :index :value |
			self assert: (sub at: index) = value ] ].
	
	"match an element"
	sub := collection copyUpToLast: self includedElement.
	self assert: sub validSequencedNewResponseFrom: collection.
	self assert: sub = (collection copyFrom: 1 to: sub size).
	self assert: (collection at: sub size + 1) = self includedElement.

	self allowsDuplicateValues ifTrue: [
		sub := collection copyUpToLast: self duplicateElement.
		self assert: sub validSequencedNewResponseFrom: collection.
		self assert: sub = (collection copyFrom: 1 to: sub size).
		self assert: (collection at: sub size + 1) = self duplicateElement.
		self assert: (sub includes: self duplicateElement) ].
	
	"Make sure we're using equality"
	(self isHomogeneous not and: [ self isInitializable ]) ifTrue: [
		collection := self collectionClass withAll: #(1 '1').
		sub := collection copyUpToLast: '1'.
		self assert: sub size = 1.
		self assert: sub first = 1 ]