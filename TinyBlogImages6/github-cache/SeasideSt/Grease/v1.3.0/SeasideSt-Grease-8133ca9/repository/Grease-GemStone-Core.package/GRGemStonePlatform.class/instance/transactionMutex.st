transactions
transactionMutex
	"Use the TransientRecursionLock, so that nested calls within same process
	 won't cause deadlock."

	TransactionMutex ifNil: [ TransactionMutex := TransientRecursionLock new ].
	^TransactionMutex