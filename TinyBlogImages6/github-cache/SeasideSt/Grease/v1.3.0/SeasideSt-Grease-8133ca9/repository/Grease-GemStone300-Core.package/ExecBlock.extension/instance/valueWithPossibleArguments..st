*grease-gemstone300-core
valueWithPossibleArguments: anArray 
     "Evaluate the block represented by the receiver with the arguments provided."
  | n args | 
  (n := self numArgs) == 0 ifTrue: [^self value].
  args := anArray copy
		size: n;
		yourself.
  ^ self valueWithArguments: args.
