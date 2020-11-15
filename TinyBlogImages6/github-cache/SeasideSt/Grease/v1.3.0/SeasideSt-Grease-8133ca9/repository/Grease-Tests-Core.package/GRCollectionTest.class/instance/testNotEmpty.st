tests
testNotEmpty
	
	self assert: self arbitraryCollection notEmpty.
	self deny:  self emptyCollection notEmpty.
	self assert: self arbitraryCollection notEmpty.
	self deny:  self emptyCollection notEmpty