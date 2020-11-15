tests
testLanguageTag
	"this makes sure the encoder doesn't fall on the nose with unicode"
	"Make Japanese String from unicode. see http://www.unicode.org/charts/PDF/U3040.pdf"
	| leading hiraA hiraO hiraAO |
	leading := (Smalltalk classNamed: #JapaneseEnvironment) leadingChar.
	hiraA := (Character 
		leadingChar: leading
		code: 12354) greaseString.	"HIRAGANA LETTER A"
	hiraO := (Character 
		leadingChar: leading
		code: 12362) greaseString.	"HIRAGANA LETTER O"
	hiraAO := hiraA , hiraO.
	self assertEncodingIgnoresLanguageTat: hiraA.
	self assertEncodingIgnoresLanguageTat: hiraO.
	self assertEncodingIgnoresLanguageTat: hiraAO