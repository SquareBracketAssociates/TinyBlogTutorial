tests
testCodecUtf8Bom
	#('UTF-8' 'utf-8') do: [ :codecName |
		| codec bom |
		codec := GRCodec forEncoding: codecName.
		bom := self asString: #(239 187 191).
		self assert: (codec decode: bom , self utf8String) greaseString = self decodedString greaseString.
		self assert: (codec url decode: bom , self utf8String) greaseString = self decodedString greaseString ]