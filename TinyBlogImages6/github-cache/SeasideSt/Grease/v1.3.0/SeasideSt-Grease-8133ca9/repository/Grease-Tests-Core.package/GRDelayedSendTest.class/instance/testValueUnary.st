tests-evaluating
testValueUnary
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #negated.
	self assert: send value = -1.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated
		arguments: #().
	self assert: send value = -1