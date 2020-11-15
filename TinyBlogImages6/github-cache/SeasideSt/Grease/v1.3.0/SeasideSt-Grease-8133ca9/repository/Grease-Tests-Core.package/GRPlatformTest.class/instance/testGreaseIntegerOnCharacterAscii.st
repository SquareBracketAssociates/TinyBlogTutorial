tests
testGreaseIntegerOnCharacterAscii
	"ASCII (1 byte)"
	self assert: $a greaseInteger = 97.
	self assert: $A greaseInteger = 65