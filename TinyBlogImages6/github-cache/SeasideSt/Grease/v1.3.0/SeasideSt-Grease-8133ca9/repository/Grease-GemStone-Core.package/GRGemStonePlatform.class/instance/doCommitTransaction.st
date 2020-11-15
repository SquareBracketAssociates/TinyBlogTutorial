transactions
doCommitTransaction

	System inTransaction ifTrue: [^SystemCommitTransaction signal].
	^true