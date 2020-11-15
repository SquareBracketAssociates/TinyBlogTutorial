as yet unclassified
testEncoderForUtf8Roundtrip
	| codec encoded string writeStream |
	codec := GRCodec forEncoding: 'utf-8'.
	"byte array with utf8 encoded characters 'a umlaut' and 'a'"
	encoded := ByteArray with: 195 with: 164 with: 97.
	string := (codec decoderFor: encoded readStream) next: 10.
	self assert: string size = 2.
	self assert: (string at: 1) asciiValue = 228.
	self assert: (string at: 2) asciiValue = 97.
	writeStream := String new writeStream.
	self assert: ((codec encoderFor: writeStream) nextPutAll: string) contents = encoded.