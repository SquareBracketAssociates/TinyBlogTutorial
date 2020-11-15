testing
testSize
	self assert: collection size = 0.
	collection addAll: #(2 1 1).
	self assert: collection size = 2.