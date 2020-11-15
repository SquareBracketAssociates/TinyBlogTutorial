conversion
decoderFor: aReadStream
	"Wrap aReadStream with an decoder for the codec of the receiver. Answer a read stream that delegates to and shares the state of aReadStream." 
	
	self subclassResponsibility