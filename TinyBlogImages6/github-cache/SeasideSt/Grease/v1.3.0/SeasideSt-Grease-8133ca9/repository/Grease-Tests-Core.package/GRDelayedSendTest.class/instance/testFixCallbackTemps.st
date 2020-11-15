tests-evaluating
testFixCallbackTemps
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #+.
	self assert: send fixCallbackTemps == send.
	send := GRDelayedSend 
		receiver: 1
		selector: #+
		argument: 2.
	self assert: send fixCallbackTemps == send