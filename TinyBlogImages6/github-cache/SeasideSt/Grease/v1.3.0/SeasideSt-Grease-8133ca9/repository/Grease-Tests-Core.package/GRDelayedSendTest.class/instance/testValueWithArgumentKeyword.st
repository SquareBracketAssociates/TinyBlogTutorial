tests-evaluating
testValueWithArgumentKeyword
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:.
	self 
		should: [ send value: 2 ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		argument: 2.
	self deny: (send value: 3).
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		arguments: #(2 3 ).
	self 
		should: [ send value: 4 ]
		raise: GRInvalidArgumentCount