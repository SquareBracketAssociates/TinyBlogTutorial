tests
testGreaseIntegerOnCharacterLatin1
	"Latin-1 (2 byte)"
	| oWithStroke |
	oWithStroke := self decodeUtf8Character: #(195 152 ).
	self assert: oWithStroke greaseInteger = 216