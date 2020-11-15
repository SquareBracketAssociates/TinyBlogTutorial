tests-enumerating
testKeysDo
	| result |
	result := OrderedCollection new.
	collection add: '1' -> 'foo'; add: '2' -> 'bar'; add: '1' -> 'baz'.
	collection keysDo: [ :each | result add: each ].
	self assert: result asArray = 
		(self allowsDuplicateKeys ifTrue: [ #('1' '2' '1') ] ifFalse: [ #('1' '2') ])