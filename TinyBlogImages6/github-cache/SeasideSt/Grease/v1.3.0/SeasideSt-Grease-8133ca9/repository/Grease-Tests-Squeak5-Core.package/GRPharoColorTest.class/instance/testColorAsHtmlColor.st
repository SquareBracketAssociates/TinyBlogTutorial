testing
testColorAsHtmlColor
	"test for:
	Color >> #hex
	| aStream |
	aStream := (String new: 6) writeStream.
	aStream nextPutAll: (((self red * 255) asInteger printStringBase: 16)
		padded: #left to: 2 with: $0).
	aStream nextPutAll: (((self green * 255) asInteger printStringBase: 16)
		padded: #left to: 2 with: $0).
	aStream nextPutAll: (((self blue * 255) asInteger printStringBase: 16)
		padded: #left to: 2 with: $0).
	^ aStream contents

	Color >> #asHTMLColor
	^ '#', self hex"
	self assert: (#('#ffffff' '#FFFFFF' ) includes: Color white asHTMLColor).
	self assert: (Color black asHTMLColor = '#000000').
	self assert: (#('#ff0000' '#FF0000' ) includes: Color red asHTMLColor)