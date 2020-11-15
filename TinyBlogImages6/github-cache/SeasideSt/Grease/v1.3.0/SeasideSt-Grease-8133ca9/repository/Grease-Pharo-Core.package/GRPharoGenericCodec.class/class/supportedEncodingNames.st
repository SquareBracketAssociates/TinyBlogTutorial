private
supportedEncodingNames
	"answers the names of the encodings supported by this class"

	^ TextConverter allEncodingNames
		removeAllFoundIn: GRPharoLatin1Codec supportedEncodingNames;
		removeAllFoundIn: UTF8TextConverter encodingNames;
		yourself