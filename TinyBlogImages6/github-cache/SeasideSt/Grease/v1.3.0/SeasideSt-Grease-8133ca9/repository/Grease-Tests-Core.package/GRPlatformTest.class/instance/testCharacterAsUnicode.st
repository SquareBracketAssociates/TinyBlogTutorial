tests
testCharacterAsUnicode
	"test for:
	Character >> #asUnicode
		^self asInteger"
	self assert: $S asUnicode = 83