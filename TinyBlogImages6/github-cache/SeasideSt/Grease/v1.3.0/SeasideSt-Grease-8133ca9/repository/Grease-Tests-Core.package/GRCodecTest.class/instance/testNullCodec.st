tests
testNullCodec
	| codec strings |
	codec := GRNullCodec new.
	strings := OrderedCollection new
		add: self latin1String;
		add: self utf8String;
		add: self utf16leString;
		add: self utf16beString;
		add: self macromanString;
		yourself.
	strings do:  [ :string | 
		self assert: (codec encode: string) = string.
		self assert: (codec url encode: string) = string.
		self assert: (codec decode: string) = string.
		self assert: (codec url decode: string) = string ]