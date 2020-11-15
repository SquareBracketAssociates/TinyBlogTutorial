tests-evaluating
testValueWithArgumentBinary
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #+.
	self assert: (send value: 2) = 3.
	send := GRDelayedSend 
		receiver: 1
		selector: #+
		argument: 2.
	self 
		should: [ send value: 2 ]
		raise: GRInvalidArgumentCount