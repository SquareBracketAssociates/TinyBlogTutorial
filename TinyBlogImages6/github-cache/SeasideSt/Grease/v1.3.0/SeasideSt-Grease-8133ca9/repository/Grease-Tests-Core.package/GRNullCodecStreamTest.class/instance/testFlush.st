tests-protocol
testFlush
	| stream |
	stream := GRNullCodec new 
		encoderFor: (WriteStream on: String new).
	stream nextPutAll: 'abc'.
	self shouldnt: [ stream flush ] raise: Error.
	self assert: stream contents = 'abc'