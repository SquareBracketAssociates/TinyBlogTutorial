tests
testCodecUtf8BorderLineString
	#('UTF-8' 'utf-8') do: [ :codecName |
		| codec writeStream |
		codec := GRCodec forEncoding: codecName.
		writeStream := codec encoderFor: GRPlatform current readWriteCharacterStream.
		writeStream nextPut: (Character codePoint: 0).
		writeStream nextPut: (Character codePoint: 255).
		writeStream nextPut: (Character codePoint: 256).
		self assert: writeStream contents = (String
			with: (Character codePoint: 16r00) "character 0" 
			with: (Character codePoint: 16rC3) with: (Character codePoint: 16rBF) "character 255" 
			with: (Character codePoint: 16rC4) with: (Character codePoint: 16r80)) "character 256"  ]