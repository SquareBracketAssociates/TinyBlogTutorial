tests
testReadString
	| stream codecStream |
	stream := 'abc' readStream.
	codecStream := GRNullCodec new decoderFor: stream.
	self assert: codecStream next = $a.
	self assert: (codecStream next: 2) = 'bc'