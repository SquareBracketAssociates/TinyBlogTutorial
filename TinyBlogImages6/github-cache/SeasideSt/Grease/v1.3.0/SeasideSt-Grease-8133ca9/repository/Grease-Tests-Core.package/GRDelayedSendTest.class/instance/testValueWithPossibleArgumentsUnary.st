tests-evaluating
testValueWithPossibleArgumentsUnary
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #negated.
	self assert: (send valueWithPossibleArguments: #()) = -1.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated
		arguments: #().
	self assert: (send valueWithPossibleArguments: #()) = -1.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated.
	self assert: (send valueWithPossibleArguments: #(2 )) = -1.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated
		arguments: #().
	self assert: (send valueWithPossibleArguments: #(2 )) = -1.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated.
	self assert: (send valueWithPossibleArguments: #(2 3 )) = -1.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated
		arguments: #().
	self assert: (send valueWithPossibleArguments: #(2 3 )) = -1