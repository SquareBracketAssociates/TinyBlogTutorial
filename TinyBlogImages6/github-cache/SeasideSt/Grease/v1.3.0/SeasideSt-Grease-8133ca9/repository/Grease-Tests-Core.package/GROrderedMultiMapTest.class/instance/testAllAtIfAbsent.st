tests-accessing
testAllAtIfAbsent
	self assert: (collection allAt: '1' ifAbsent: [ 'absent' ]) = 'absent'.
	collection at: '1' add: 'foo'.
	collection at: '1' add: 'bar'.
	self assert: (collection allAt: '1' ifAbsent: [ 'absent' ]) = #( 'foo' 'bar' )