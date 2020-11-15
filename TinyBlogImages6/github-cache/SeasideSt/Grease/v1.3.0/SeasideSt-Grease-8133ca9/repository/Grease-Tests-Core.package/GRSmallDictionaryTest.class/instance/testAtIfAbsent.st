tests-accessing
testAtIfAbsent
	self assert: (collection at: '1' ifAbsent: [ 'foo' ]) = 'foo'.
	collection add: '1' -> 'bar'.
	collection add: '1' -> 'baz'.
	self assert: (collection at: '1' ifAbsent: [ 'foo' ]) = 
		(self allowsDuplicateKeys ifTrue: [ 'bar' ] ifFalse: [ 'baz' ])