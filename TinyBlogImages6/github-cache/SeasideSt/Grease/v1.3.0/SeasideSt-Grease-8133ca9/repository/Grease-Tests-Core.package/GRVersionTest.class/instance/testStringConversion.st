tests
testStringConversion
	self assert: (GRVersion major: 1 minor: 2 revision: 3) greaseString = '1.2.3'.
	self assert: (GRVersion major: 11 minor: 12 revision: 13) greaseString = '11.12.13'.
	self assert: (GRVersion major: 1 minor: 2) greaseString = '1.2'.
	self assert: (GRVersion major: 1 minor: 2 revision: 0) greaseString = '1.2.0'.
	self assert: (GRVersion major: 1) greaseString = '1.0'.
	self assert: ((GRVersion major: 1 minor: 2 revision: 3) beAlpha) greaseString = '1.2.3alpha'.
	self assert: ((GRVersion major: 1 minor: 2 revision: 3) beAlpha: 1) greaseString = '1.2.3alpha1'.
	self assert: ((GRVersion major: 1 minor: 2 revision: 3) beBeta) greaseString = '1.2.3beta'.
	self assert: ((GRVersion major: 1 minor: 2 revision: 3) beBeta: 1) greaseString = '1.2.3beta1'