tests
testBlockValuableProtocol
	self assert: [ nil ] argumentCount isZero.
	self assert: [ :x | x ] argumentCount = 1.
	self assert: [ :a :b | a + b ] argumentCount = 2.
	self 
		shouldnt: [ [ nil ] fixCallbackTemps ]
		raise: Error.
	self 
		shouldnt: [ [ :x | x ] fixCallbackTemps ]
		raise: Error.
	self 
		shouldnt: [ [ :a :b | a + b ] fixCallbackTemps ]
		raise: Error