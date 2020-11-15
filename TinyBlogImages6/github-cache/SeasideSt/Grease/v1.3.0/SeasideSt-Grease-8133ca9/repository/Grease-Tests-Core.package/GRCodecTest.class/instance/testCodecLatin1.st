tests
testCodecLatin1
	#('iso-8859-1' 'ISO-8859-1' ) do:  [ :each | 
		| codec |
		codec := GRCodec forEncoding: each.
		self assert: codec name = each.
		self assert: codec url name = each.
		
		"Dialects may not guarantee anything about the comparability of
		 encoded strings.  Convert to Strings for simplicity."
		self assert: (codec encode: self decodedString) greaseString = self latin1String greaseString.
		self assert: (codec url encode: self decodedString) greaseString = self latin1String greaseString.
		self assert: (codec decode: self latin1String) = self decodedString.
		self assert: (codec url decode: self latin1String) = self decodedString ]