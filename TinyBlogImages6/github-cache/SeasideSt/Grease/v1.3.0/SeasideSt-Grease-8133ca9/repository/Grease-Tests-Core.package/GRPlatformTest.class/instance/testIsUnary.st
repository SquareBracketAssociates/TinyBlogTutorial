tests
testIsUnary
	self assert: #isUnary isUnary.
	self deny: #+ isUnary.
	self deny: #isUnary: isUnary.
	self deny: #isUnary:isUnary: isUnary