*grease-gemstone-core
valueWithPossibleArgument: anArg

     "Evaluate the block represented by the receiver.
     If the block requires one argument, use anArg, if it requires more than one,
     fill up the rest with nils."

	^self numArgs = 0
		ifTrue: [ self value ]
	    	ifFalse: [
			receiver
				perform: selector
				withArguments: ((self arguments, (Array with: anArg)) first: self numArgs) ]