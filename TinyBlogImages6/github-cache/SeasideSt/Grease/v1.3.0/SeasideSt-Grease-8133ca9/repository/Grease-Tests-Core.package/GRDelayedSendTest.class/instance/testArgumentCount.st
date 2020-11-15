tests-accessing
testArgumentCount
	" unary "
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #negated.
	self assert: send argumentCount = 0.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated
		arguments: #().
	self assert: send argumentCount = 0.

	" binary "
	send := GRDelayedSend 
		receiver: 1
		selector: #+.
	self assert: send argumentCount = 1.
	send := GRDelayedSend 
		receiver: 1
		selector: #+
		argument: 2.
	self assert: send argumentCount = 0.

	" keyword "
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:.
	self assert: send argumentCount = 2.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		argument: 2.
	self assert: send argumentCount = 1.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		arguments: (Array 
				with: 2
				with: 3).
	self assert: send argumentCount = 0