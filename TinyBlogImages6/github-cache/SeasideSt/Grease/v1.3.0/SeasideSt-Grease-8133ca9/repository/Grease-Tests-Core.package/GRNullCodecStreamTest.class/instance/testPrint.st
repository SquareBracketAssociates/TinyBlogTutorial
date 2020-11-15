tests-protocol
testPrint
	| stream |
	stream := GRNullCodec new 
		encoderFor: (WriteStream on: String new).
	stream print: 123.
	self assert: stream contents = '123'