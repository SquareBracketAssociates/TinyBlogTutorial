tests
testNext
	#('iso-8859-1' 'ISO-8859-1' ) do:  [ :each | 
		| stream |
		stream := (GRCodec forEncoding: each)
			encoderFor: self seasideByteArray readStream.
		self assert: stream next = $S.
		self assert: (stream next: 1) = 'e' ]