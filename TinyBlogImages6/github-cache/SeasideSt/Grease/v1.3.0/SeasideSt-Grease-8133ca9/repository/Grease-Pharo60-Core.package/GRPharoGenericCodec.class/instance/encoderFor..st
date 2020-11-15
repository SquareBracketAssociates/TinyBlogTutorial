conversion
encoderFor: aStream 
	^ GRPharoConverterCodecStream 
		on: aStream
		converter: self converter