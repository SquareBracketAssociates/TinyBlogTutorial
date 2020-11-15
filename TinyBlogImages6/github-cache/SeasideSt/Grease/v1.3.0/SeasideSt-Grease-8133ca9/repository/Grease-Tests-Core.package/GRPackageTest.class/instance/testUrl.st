tests
testUrl
	self assert: package url isNil.
	
	package url: #seasideLGPLUrl.
	self assert: package url = GRPackage new seasideLGPLUrl. 
	
	package url: 'http://www.seaside.st/distributions'.
	self assert: package url = 'http://www.seaside.st/distributions'