tests
testCodecLatin1BorderLineString
	#('iso-8859-1' 'ISO-8859-1' ) do:  [ :each | 
		| codec writeStream |
		codec := GRCodec forEncoding: each.
		writeStream := codec encoderFor: GRPlatform current readWriteCharacterStream.
		writeStream nextPut: (Character codePoint: 0).
		writeStream nextPut: (Character codePoint: 255).
		self assert: writeStream contents = (String with: (Character codePoint: 0) with: (Character codePoint: 255)) ]