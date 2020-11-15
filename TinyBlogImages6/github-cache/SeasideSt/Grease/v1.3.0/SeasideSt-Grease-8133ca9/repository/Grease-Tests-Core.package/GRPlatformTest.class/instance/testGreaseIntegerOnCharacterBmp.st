tests
testGreaseIntegerOnCharacterBmp
	"BMP (3 byte)"
	| euro |
	euro := self decodeUtf8Character: #(226 130 172 ).
	self assert: euro greaseInteger = 8364