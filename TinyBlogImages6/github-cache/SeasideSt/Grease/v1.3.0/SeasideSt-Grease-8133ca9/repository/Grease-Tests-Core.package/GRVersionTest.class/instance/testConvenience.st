tests
testConvenience
	| version |
	version := GRVersion major: 1 minor: 2 revision: 3.
	self assert: version stage isNil.
	self assert: version stageNumber isNil.
	self assert: version isFinal.
	self deny: version isAlpha.
	self deny: version isBeta.
	version beAlpha.
	self assert: version stage = #alpha.
	self assert: version stageNumber isNil.
	self assert: version isAlpha.
	self deny: version isBeta.
	self deny: version isFinal.
	version beBeta.
	self assert: version stage = #beta.
	self assert: version stageNumber isNil.
	self assert: version isBeta.
	self deny: version isAlpha.
	self deny: version isFinal.
	version beReleaseCandidate.
	self assert: version stage = #rc.
	self assert: version stageNumber isNil.
	self assert: version isReleaseCandidate.
	version beReleaseCandidate: 1.
	self assert: version stage = #rc.
	self assert: version stageNumber = 1.
	self assert: version isReleaseCandidate.
	version beAlpha: 1.
	self assert: version stage = #alpha.
	self assert: version stageNumber = 1.
	self assert: version isAlpha.
	self deny: version isBeta.
	self deny: version isFinal.
	version beBeta: 1.
	self assert: version stage = #beta.
	self assert: version stageNumber = 1.
	self assert: version isBeta.
	self deny: version isAlpha.
	self deny: version isFinal.
	version beFinal.
	self assert: version stage isNil.
	self assert: version stageNumber isNil.
	self assert: version isFinal.
	self deny: version isAlpha.
	self deny: version isBeta