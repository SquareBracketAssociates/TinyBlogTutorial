tests-enumerating
testValues
	collection add: '1' -> 'foo'; add: '2' -> 'bar'; add: '1' -> 'baz'.
	self assert: collection values =
		(self allowsDuplicateKeys ifTrue: [ #('foo' 'bar' 'baz') ] ifFalse: [ #('baz' 'bar') ])