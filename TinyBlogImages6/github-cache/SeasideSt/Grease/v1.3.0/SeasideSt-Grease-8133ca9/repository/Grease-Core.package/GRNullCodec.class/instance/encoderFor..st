conversion
encoderFor: aWriteStream 
	"wrap to avoid String vs ByteArray issues"
	^ GRNullCodecStream on: aWriteStream