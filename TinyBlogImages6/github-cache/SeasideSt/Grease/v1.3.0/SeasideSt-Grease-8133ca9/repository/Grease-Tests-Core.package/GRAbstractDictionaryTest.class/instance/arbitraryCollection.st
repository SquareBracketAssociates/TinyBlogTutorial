configuration
arbitraryCollection
	| dict |
	dict := self emptyCollection.
	self arbitraryAssociations do: [ :each |
		dict at: each key put: each value ].
	^ dict