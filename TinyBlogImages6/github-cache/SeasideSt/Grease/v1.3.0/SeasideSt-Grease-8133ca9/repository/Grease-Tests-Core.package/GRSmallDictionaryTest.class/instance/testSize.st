tests-accessing
testSize
	self assert: collection size = 0.
	collection add: '1' -> 'foo'.
	self assert: collection size = 1.
	collection add: '2' -> 'bar'.
	self assert: collection size = 2.
	collection add: '1' -> 'baz'.
	self assert: collection size = 
		(self allowsDuplicateKeys ifTrue: [ 3 ] ifFalse: [ 2 ])