conversion
encoderFor: aWriteStream 
	"wrap to avoid String vs ByteArray issues"
	^ GRPharoLatin1CodecStream on: aWriteStream