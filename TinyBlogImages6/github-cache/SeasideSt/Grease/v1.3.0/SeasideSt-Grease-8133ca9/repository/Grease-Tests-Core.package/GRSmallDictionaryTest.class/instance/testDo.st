tests-enumerating
testDo
	| result |
	result := OrderedCollection new.
	collection at: '1' put: 'foo'; at: '2' put: 'bar'.
	collection do: [ :each | result add: each ].
	self assert: result asArray = #( 'foo' 'bar' )