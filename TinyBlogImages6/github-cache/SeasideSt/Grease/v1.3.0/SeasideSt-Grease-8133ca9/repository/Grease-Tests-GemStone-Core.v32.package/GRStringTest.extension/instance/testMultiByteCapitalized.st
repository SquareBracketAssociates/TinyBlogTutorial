*grease-tests-gemstone-core
testMultiByteCapitalized
	self assert: (self multiByteConvert: 'capitalized') capitalized = 'Capitalized'.
	self assert: (self multiByteConvert: 'Capitalized') capitalized = 'Capitalized' .
	self assert: (self multiByteConvert: 'CAPITALIZED') capitalized = 'CAPITALIZED' .