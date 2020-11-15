tests
testReset
	| contents |
	contents := String streamContents: [ :s |
		| stream |
		stream := (GRCodec forEncoding: 'ISO-8859-1') encoderFor: s.
		stream
			nextPutAll: 'abc';
			reset;
			nextPut: $d ].
	self assert: contents = 'd'