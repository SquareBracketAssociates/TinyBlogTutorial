tests-evaluating
testValueKeyword
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:.
	self 
		should: [ send value ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		argument: 2.
	self 
		should: [ send value ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		arguments: (Array 
				with: 2
				with: 3).
	self deny: send value