tests
testAssociationsDo
	| collection assocs count |
	collection := self arbitraryCollection.
	assocs := self arbitraryAssociations copy.
	count := 0.
	collection associationsDo: [ :assoc |
		| size |
		count := count + 1.
		size := assocs size.
		assocs := assocs
			reject: [ :each |
				(self isKey: each key equivalentTo: assoc key)
					and: [ each value = assoc value ] ].
		self assert: size - 1 = assocs size ].
	self assert: assocs isEmpty.
	self assert: count = self arbitraryAssociations size