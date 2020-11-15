tests
testVersion
	self assert: (self platform version isKindOf: GRVersion).
	self assert: (self platform versionString isKindOf: String).
	self deny: self platform versionString isEmpty