*grease-gemstone-core
doTransaction: aBlock
  "Evaluate aBlock in a transaction. 
	 Return true if the transaction succeeds and false if the transaction fails.
	 Nested calls are allowed and will always return true.
	 See System class>>transactionConflicts for dealing with failed transactions."

  "Ensure that each block evaluation is mutually exclusive: https://code.google.com/p/glassdb/issues/detail?id=355"

  self transactionMutex
    critical: [ 
      | commitResult |
      "Get the transactionMutex, and perform the transaction."
      System inTransaction
        ifTrue: [ 
          "We already are in a transaction, so just evaluate the block"
          aBlock value.
          ^ true ]
        ifFalse: [ 
          [ 
          self doBeginTransaction.
          aBlock value ]
            ensure: [ 
              "workaround for Bug 42963: ensure: block executed twice (don't return from ensure: block)"
              commitResult := self doCommitTransaction ] ].
      ^ commitResult ]