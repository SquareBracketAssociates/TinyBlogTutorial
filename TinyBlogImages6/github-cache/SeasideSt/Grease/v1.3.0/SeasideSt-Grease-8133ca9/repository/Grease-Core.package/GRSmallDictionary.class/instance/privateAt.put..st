private
privateAt: aKey put: aValue
	size = keys size ifTrue: [ self grow ].
	keys at: (size := size + 1) put: aKey.
	^ values at: size put: aValue