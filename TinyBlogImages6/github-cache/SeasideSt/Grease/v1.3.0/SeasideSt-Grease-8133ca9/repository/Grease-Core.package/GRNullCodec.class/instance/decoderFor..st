conversion
decoderFor: aReadStream 
	"wrap to avoid String vs ByteArray issues"
	^ GRNullCodecStream on: aReadStream