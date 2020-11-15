tests-accessing
testRemoveKey
	self should: [ collection removeKey: '1' ] raise: Error.
	collection add: '1' -> 'foo'.
	collection add: '1' -> 'bar'.
	collection add: '2' -> 'baz'.
	self assert: (collection removeKey: '1') =
		(self allowsDuplicateKeys ifTrue: [ #('foo' 'bar') ] ifFalse: [ 'bar' ]).
	self assertAssociations: (Array with: '2' -> 'baz').
	self assert: (collection removeKey: '2') =
		(self allowsDuplicateKeys ifTrue: [ #('baz') ] ifFalse: [ 'baz' ]).
	self assertAssociations: #()