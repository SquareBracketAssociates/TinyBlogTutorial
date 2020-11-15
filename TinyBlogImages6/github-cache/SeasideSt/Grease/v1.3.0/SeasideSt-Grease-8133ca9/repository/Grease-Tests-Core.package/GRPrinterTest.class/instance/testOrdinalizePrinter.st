tests
testOrdinalizePrinter
	| converter |
	converter := GRNumberPrinter new , GROrdinalizePrinter new.
	self assert: (converter print: 1) = '1st'.
	self assert: (converter print: 2) = '2nd'.
	self assert: (converter print: 3) = '3rd'.
	self assert: (converter print: 4) = '4th'.
	self assert: (converter print: 10) = '10th'.
	self assert: (converter print: 111) = '111th'.
	self assert: (converter print: 212) = '212th'.
	self assert: (converter print: 313) = '313th'.
	self assert: (converter print: 414) = '414th'.
	self assert: (converter print: 20) = '20th'.
	self assert: (converter print: 121) = '121st'.
	self assert: (converter print: 222) = '222nd'.
	self assert: (converter print: 323) = '323rd'.
	self assert: (converter print: 424) = '424th'