tests
testStringPrinter
	| converter |
	converter := GRStringPrinter new.
	self assert: (converter print: 123) = '123'.
	self assert: (converter print: 'foo') = 'foo'.
	self assert: (converter print: true) = 'true'