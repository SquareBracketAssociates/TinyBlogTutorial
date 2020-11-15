tests-enumerating
testKeys
	collection add: '1' -> 'foo'; add: '2' -> 'bar'; add: '1' -> 'baz'.
	self assert: collection keys =
		(self allowsDuplicateKeys ifTrue: [ #('1' '2' '1') ] ifFalse: [ #('1' '2') ])