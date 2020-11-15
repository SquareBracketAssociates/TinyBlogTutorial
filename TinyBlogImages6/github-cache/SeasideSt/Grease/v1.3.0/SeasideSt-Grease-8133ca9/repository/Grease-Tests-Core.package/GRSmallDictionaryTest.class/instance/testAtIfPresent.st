tests-accessing
testAtIfPresent
	collection add: '1' -> 'foo'.
	collection add: '1' -> 'bar'.
	self assert: (collection at: '1' ifPresent: [ :v | v , 'baz' ]) =
		(self allowsDuplicateKeys ifTrue: [ 'foobaz' ] ifFalse: [ 'barbaz' ]).
	self assert: (collection at: '2' ifPresent: [ :v | v , 'baz' ]) isNil