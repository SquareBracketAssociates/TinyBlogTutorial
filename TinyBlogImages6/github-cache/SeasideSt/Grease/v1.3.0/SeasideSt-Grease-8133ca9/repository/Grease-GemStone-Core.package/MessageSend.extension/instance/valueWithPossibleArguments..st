*grease-gemstone-core
valueWithPossibleArguments: anArray

     "Evaluate the block represented by the receiver.
     If the block requires one argument, use anArg, if it requires more than one,
     fill up the rest with nils."

	| count |
	^(count := selector argumentCount) = 0
		ifTrue: [ self value ]
	    	ifFalse: [
			receiver
				perform: selector
				withArguments: ((self arguments, anArray) first: count) ]