tests-accessing
testAllAt
	self assert: (collection allAt: '1') = #().
	collection at: '1' add: 'foo'.
	collection at: '1' add: 'bar'.
	self assert: (collection allAt: '1') = #( 'foo' 'bar' )