tests
testNotificationInitialization
	"Make sure #initialize is called on #new and that calling 'super initialize' doesn't error."
	self assert: GRNotificationStub new foo