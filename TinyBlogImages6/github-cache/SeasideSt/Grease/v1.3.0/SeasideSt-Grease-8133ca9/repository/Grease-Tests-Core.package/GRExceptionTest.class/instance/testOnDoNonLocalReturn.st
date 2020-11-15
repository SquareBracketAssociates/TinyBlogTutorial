tests
testOnDoNonLocalReturn
	"You should be able to do a non-local return from within an exception
	handler block. We rely on a helper method here so we can check the return
	value."
	
	self assert: (self onExceptionReturn: 123) == 123