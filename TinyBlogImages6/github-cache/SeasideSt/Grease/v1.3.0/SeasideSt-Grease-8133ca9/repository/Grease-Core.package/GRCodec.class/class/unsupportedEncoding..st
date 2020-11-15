private
unsupportedEncoding: aString
	"Signal an unsupported encoding."

	^ GRUnsupportedEncodingError signal: 'unsupported encoding: ' , aString