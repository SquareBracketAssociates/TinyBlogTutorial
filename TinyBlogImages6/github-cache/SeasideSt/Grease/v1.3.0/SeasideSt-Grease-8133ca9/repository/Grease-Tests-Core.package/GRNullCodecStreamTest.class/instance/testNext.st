tests-protocol
testNext
	| stream |
	stream := GRNullCodec new
		encoderFor: 'Seaside' readStream.
	self assert: stream next = $S.
	self assert: (stream next: 1) = 'e'