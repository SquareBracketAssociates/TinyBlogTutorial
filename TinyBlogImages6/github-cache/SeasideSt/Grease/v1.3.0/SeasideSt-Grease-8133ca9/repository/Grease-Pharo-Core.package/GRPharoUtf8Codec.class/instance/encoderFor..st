conversion
encoderFor: aStream 
	^ GRPharoUtf8CodecStream 
		on: aStream
		converter: UTF8TextConverter new