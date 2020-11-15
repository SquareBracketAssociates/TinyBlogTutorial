tests-evaluating
testValueWithArgumentsBinary
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #+.
	self 
		should: [ send valueWithArguments: #(2 3 ) ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #+
		argument: 2.
	self 
		should: [ send valueWithArguments: #(3 4 ) ]
		raise: GRInvalidArgumentCount