tests-evaluating
testValueWithArgumentsKeyword
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:.
	self deny: (send valueWithArguments: #(2 3 )).
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		argument: 2.
	self 
		should: [ send valueWithArguments: #(3 4 ) ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		arguments: #(2 3 ).
	self 
		should: [ send valueWithArguments: #(4 5 ) ]
		raise: GRInvalidArgumentCount