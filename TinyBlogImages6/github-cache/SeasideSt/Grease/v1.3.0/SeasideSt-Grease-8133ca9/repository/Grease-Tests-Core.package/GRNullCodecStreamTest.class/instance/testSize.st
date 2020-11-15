tests-protocol
testSize
	| stream |
	stream := GRNullCodec new 
		encoderFor: (WriteStream on: String new).
	stream nextPutAll: 'abc'.
	self assert: stream size = 3.
	stream nextPut: $d.
	self assert: stream size = 4