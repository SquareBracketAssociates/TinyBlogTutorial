tests-evaluating
testValueBinary
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #+.
	self 
		should: [ send value ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #+
		argument: 2.
	self assert: send value = 3