tests
testLicense
	self assert: package license = #MIT.
	self assert: package isMIT.
	
	package license: #LGPL.
	self assert: package license = #LGPL.
	self assert: package isLGPL