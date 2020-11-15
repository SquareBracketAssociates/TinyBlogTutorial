tests-evaluating
testValueWithPossibleArgumentsKeyword
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:.
	self 
		should: [ send valueWithPossibleArguments: #() ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		argument: 2.
	self 
		should: [ send valueWithPossibleArguments: #() ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		arguments: (Array 
				with: 2
				with: 3).
	self deny: (send valueWithPossibleArguments: #()).
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:.
	self 
		should: [ send valueWithPossibleArguments: #(2 ) ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		argument: 2.
	self deny: (send valueWithPossibleArguments: #(3 )).
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		arguments: (Array 
				with: 2
				with: 3).
	self deny: (send valueWithPossibleArguments: #(4 )).
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:.
	self deny: (send valueWithPossibleArguments: #(2 3 )).
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		argument: 2.
	self deny: (send valueWithPossibleArguments: #(3 4 )).
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		arguments: (Array 
				with: 2
				with: 3).
	self deny: (send valueWithPossibleArguments: #(4 5 ))