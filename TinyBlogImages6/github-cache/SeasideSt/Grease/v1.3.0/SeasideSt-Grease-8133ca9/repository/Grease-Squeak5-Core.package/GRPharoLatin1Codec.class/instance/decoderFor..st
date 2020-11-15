conversion
decoderFor: aReadStream 
	"wrap to avoid String vs ByteArray issues"
	^ GRPharoLatin1CodecStream on: aReadStream