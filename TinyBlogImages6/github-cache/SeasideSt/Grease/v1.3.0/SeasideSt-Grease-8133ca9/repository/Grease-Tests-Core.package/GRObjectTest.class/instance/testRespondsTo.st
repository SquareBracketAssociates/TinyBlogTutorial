tests
testRespondsTo
	self assert: (GRObject new respondsTo: #greaseString).
	self deny: (GRObject new respondsTo: #makeMeASandwich)