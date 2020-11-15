tests
testOnDoImplicitReturn
	"According to ANSI 5.5.15.2, an exception handler block that runs to completion
	should result in the call to #on:do: returning the block's value."
	
	| result |
	result := [ GRErrorStub signal ] on: GRErrorStub do: [ :e | #blockValue ].
	self assert: result = #blockValue.
	
	result := nil.
	result := [ GRNotificationStub signal ] on: GRNotificationStub do: [ :e | #blockValue ].
	self assert: result = #blockValue