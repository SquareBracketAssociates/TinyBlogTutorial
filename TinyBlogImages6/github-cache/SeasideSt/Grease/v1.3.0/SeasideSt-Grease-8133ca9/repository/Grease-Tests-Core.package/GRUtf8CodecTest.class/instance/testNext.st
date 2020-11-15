tests
testNext
	| stream |
	stream := (GRCodec forEncoding: 'utf8')
		encoderFor: self seasideByteArray readStream.
	self assert: stream next = $S.
	self assert: (stream next: 1) = 'e'