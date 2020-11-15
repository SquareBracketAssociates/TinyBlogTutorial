conversion
encoderFor: aWriteStream
	"Wrap aWriteStream with an encoder for the codec of the receiver. Answer a write stream that delegates to and shares the state of aWriteStream."
	
	self subclassResponsibility