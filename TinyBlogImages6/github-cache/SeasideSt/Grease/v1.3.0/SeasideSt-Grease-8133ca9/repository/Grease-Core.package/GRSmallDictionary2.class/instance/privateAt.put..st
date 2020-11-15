private
privateAt: aKey put: aValue
	size * 2 = table size ifTrue: [ self grow ].
	table at: (size * 2 + 1) put: aKey.
	table at: (size * 2 + 2) put: aValue.
	size := size + 1.
	^ aValue