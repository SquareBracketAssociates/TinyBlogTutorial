tests-accessing
testAddAll
	| dict result |
	dict := (Dictionary new at: '1' put: 'foo'; yourself).
	result := collection addAll: dict.
	self assert: result == dict.
	self assertAssociations: (Array with: '1' -> 'foo').
	
	dict := (GROrderedMultiMap new at: '1' put: 'foo'; at: '1' add: 'bar'; yourself).
	collection := self newCollection.
	result := collection addAll: dict.
	self assert: result == dict.
	self assertAssociations:
		(self allowsDuplicateKeys
			ifFalse: [ Array with: '1' -> 'bar' ]
			ifTrue: [ Array with: '1' -> 'foo' with: '1' -> 'bar' ])
