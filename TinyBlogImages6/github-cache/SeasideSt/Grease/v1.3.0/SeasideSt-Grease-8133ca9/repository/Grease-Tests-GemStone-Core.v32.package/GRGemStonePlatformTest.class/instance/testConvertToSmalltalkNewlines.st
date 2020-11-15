testing
testConvertToSmalltalkNewlines
	"GemStone uses lf as native newline character"

	| expected got codePoint euro |
	expected := 'selector', String lf, '"comment"'.
	got := GRPlatform current convertToSmalltalkNewlines: expected.
	codePoint := (got at: 9) codePoint.
	self assert: expected = got.
	self assert: expected = (GRPlatform current
		convertToSmalltalkNewlines: ('selector', String lf, '"comment"')).
	self assert: expected = (GRPlatform current
		convertToSmalltalkNewlines: ('selector', String crlf, '"comment"')).
		
	euro := (String with: (Character value: 8364)).
	self assert: expected, euro = (GRPlatform current
		convertToSmalltalkNewlines: expected, euro).
		
	self assert: (GRPlatform current convertToSmalltalkNewlines: nil) isNil