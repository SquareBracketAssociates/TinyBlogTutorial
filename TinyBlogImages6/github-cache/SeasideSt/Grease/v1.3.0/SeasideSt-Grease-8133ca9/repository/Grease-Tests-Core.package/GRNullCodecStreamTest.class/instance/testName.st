tests-characters
testName
	| codec |
	codec := GRNullCodec new.
	
	self assert: codec name = GRNullCodec codecName