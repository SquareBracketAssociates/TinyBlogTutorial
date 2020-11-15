tests-evaluating
testValueValueKeyword
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:.
	self deny: (send 
			value: 2
			value: 3).
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		argument: 2.
	self 
		should: 
			[ send 
				value: 4
				value: 5 ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		arguments: (Array 
				with: 2
				with: 3).
	self 
		should: 
			[ send 
				value: 4
				value: 5 ]
		raise: GRInvalidArgumentCount