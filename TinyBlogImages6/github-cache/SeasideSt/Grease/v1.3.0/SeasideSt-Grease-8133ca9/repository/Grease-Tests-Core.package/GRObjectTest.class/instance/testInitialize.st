tests
testInitialize
	"Make sure #initialize is called on #new and that calling 'super initialize' doesn't error."
	self assert: GRObjectStub new foo