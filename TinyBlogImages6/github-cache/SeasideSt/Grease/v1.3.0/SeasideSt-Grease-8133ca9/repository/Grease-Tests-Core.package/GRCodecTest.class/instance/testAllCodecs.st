tests
testAllCodecs
	self assert: GRCodec allCodecs notEmpty.
	GRCodec allCodecs do: [ :codec | 
		self deny: codec class = GRCodec.
		self assert: (codec isKindOf: GRCodec) ]