class initialization
initialize
	self select.
	self current transactionMutex	"http://code.google.com:9393/p/glassdb/issues/detail?id=290 	transactionMutex is always nil"