testing
testAllColors
	| toTest |
	toTest := #(
		16r000000 16r000001 16r000101 16r010101 16r010100 16r010000 16r001001 16r101001
		16r001122 16r334455 16r667788 16r99AABB 16rCCDDEE 16rFF0011
		16r123456 16r789ABC 16rDEFEDC
		16rFEFEEF 16rFEFEFF 16rFEFEFE 16rFFFEFE 16rFFFFFE 16rFFFFFF).
	toTest do: [ :int | 
		| hex |
		hex := int printPaddedWith: $0 to: 6 base: 16.
		self assert: (Color fromString: hex) asHTMLColor asLowercase = ('#', hex) asLowercase ]