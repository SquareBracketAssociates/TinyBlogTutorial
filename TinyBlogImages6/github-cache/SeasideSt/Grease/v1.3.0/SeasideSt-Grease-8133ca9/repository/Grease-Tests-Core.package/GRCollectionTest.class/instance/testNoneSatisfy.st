tests
testNoneSatisfy
	| excluded included |
	excluded := self excludedElement.
	self assert: (self arbitraryCollection noneSatisfy: [ :each | each = excluded ]).
	included := self includedElement.
	self deny: (self arbitraryCollection noneSatisfy: [ :each | each = included ]).
	self assert: (self emptyCollection noneSatisfy: [ :each | true ])