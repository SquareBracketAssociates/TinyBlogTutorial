tests-evaluating
testValueWithArgumentsUnary
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #negated.
	self 
		should: [ send valueWithArguments: #(2 3 ) ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated
		arguments: #().
	self 
		should: [ send valueWithArguments: #(2 3 ) ]
		raise: GRInvalidArgumentCount