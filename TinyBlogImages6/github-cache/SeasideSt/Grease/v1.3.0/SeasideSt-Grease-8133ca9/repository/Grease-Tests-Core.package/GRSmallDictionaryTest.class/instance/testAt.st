tests-accessing
testAt
	self should: [ collection at: '1' ] raise: Error.
	collection add: '1' -> 'foo'.
	collection add: '1' -> 'bar'.
	self assert: (collection at: '1') =
		(self allowsDuplicateKeys ifTrue: [ 'foo' ] ifFalse: [ 'bar' ])