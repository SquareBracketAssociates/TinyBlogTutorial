tests
testIsKeyword
	self deny: #isKeyword isKeyword.
	self deny: #+ isKeyword.
	self assert: #isKeyword: isKeyword.
	self assert: #isKeyword:isKeyword: isKeyword