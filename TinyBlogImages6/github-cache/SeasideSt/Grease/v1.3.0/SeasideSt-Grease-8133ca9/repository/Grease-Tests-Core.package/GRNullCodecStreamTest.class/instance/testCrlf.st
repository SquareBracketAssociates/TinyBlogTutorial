tests-characters
testCrlf
	| stream |
	stream := GRNullCodec new 
		encoderFor: (WriteStream on: String new).
	stream crlf.
	
	self assert: stream contents size = 2.
	self assert: stream contents first = Character cr.
	self assert: stream contents last = Character lf