tests
testLabel
	self assert: (self platform label isKindOf: String).
	self deny: self platform label isEmpty