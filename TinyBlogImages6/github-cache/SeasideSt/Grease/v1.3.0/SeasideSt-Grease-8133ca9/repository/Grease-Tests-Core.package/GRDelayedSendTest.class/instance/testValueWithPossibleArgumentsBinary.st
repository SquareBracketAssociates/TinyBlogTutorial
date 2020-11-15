tests-evaluating
testValueWithPossibleArgumentsBinary
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #+.
	self 
		should: [ send valueWithPossibleArguments: #() ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #+
		argument: 2.
	self assert: (send valueWithPossibleArguments: #()) = 3.
	send := GRDelayedSend 
		receiver: 1
		selector: #+.
	self assert: (send valueWithPossibleArguments: #(2 )) = 3.
	send := GRDelayedSend 
		receiver: 1
		selector: #+
		argument: 2.
	self assert: (send valueWithPossibleArguments: #(3 )) = 3.
	send := GRDelayedSend 
		receiver: 1
		selector: #+.
	self assert: (send valueWithPossibleArguments: #(2 3 )) = 3.
	send := GRDelayedSend 
		receiver: 1
		selector: #+
		argument: 2.
	self assert: (send valueWithPossibleArguments: #(3 4 )) = 3