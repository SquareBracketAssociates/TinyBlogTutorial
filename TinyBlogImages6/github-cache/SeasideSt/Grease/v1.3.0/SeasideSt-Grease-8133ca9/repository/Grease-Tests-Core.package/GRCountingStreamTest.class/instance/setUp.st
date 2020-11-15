running
setUp
	| codecStream |
	codecStream := ((GRCodec forEncoding: 'utf-8') encoderFor: (WriteStream on: String new)).
	countingStream := GRCountingStream on: codecStream