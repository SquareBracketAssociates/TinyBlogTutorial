tests-evaluating
testValueValueBinary
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #+.
	self 
		should: 
			[ send 
				value: 2
				value: 3 ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #+
		argument: 2.
	self 
		should: 
			[ send 
				value: 2
				value: 3 ]
		raise: GRInvalidArgumentCount