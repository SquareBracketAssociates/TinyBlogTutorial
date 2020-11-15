tests-enumerating
testKeysAndValuesDo
	| iterated |
	collection keysAndValuesDo: [ :key :value |
		self assert: false ].
	collection add: '1' -> 'foo'; add: '2' -> 'bar'; add: '1' -> 'baz'.
	iterated := Array streamContents: [ :stream |
		collection keysAndValuesDo: [ :key :value |
			stream nextPut: key -> value ] ].
	self assert: iterated size = (self allowsDuplicateKeys ifTrue: [ 3 ] ifFalse: [ 2 ]).
	self assert: iterated first =
		(self allowsDuplicateKeys ifTrue: [ '1' -> 'foo' ] ifFalse: [ '1' -> 'baz' ]).
	self assert: iterated second = ('2' -> 'bar').
	self allowsDuplicateKeys ifTrue: [
		self assert: iterated third = ('1' -> 'baz') ]