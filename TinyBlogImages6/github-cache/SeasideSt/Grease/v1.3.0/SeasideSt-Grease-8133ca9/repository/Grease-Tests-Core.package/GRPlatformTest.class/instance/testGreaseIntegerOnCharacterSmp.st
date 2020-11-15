tests
testGreaseIntegerOnCharacterSmp
	"SMP (4 byte)"
	| manna |
	manna := self decodeUtf8Character: #(240 144 140 188 ).
	self assert: manna greaseInteger = 66364