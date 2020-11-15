tests
testEndsWithSubCollection
	self assert: ((-5 to: 10 by: 3) endsWithSubCollection: (-2 to: 10 by: 3)).
	self assert: ((-5 to: 10 by: 3) endsWithSubCollection: (-5 to: 10 by: 3)).
	self deny: ((-5 to: 10 by: 3) endsWithSubCollection: (-5 to: 13 by: 3))