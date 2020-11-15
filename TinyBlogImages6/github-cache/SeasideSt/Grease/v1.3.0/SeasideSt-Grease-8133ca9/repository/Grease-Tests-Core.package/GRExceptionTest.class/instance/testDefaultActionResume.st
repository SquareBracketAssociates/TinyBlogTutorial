tests
testDefaultActionResume
	"According to ANSI 5.5.15.2, the result of #defaultAction
	should be used to resume resumable exceptions. Behaviour is undefined
	for non-resumable exceptions so we do not test for that case."
	
	| result |
	result := GRNotificationStub signal.
	self assert: result = #returnValue