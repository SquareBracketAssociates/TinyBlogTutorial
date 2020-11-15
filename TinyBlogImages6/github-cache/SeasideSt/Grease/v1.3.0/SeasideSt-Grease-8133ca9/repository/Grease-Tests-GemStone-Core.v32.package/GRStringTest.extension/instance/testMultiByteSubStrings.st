*grease-tests-gemstone-core
testMultiByteSubStrings
	"#subStrings: is defined by ANSI 5.7.10.15:
	Answer an array containing the substrings in the receiver separated by the elements of separators."
	| mimeType tokens |
	mimeType := (self multiByteConvert: 'application/xhtml+xml').
	tokens := mimeType subStrings: '/'.
	self assert: tokens size = 2.
	self assert: tokens first = 'application'.
	self assert: tokens second = 'xhtml+xml'.
	
	"ANSI is a bit unclear on how multiple sequential delimiters should be treated.
	Make sure behaviour is consistent for several delimiters in a row (taken from
	Squeak's behaviour)"
	tokens := (self multiByteConvert: 'abc,.def.ghi') subStrings: '.,'.
	self assert: tokens size = 3.
	self assert: tokens first = 'abc'.
	self assert: tokens second = 'def'.
	self assert: tokens third = 'ghi'.

	"also ensure behavior consistent for several delimiters in a row at beginning and end of string...for completeness"
	tokens := (self multiByteConvert: ',.abc,.def.ghi.,') subStrings: '.,'.
	self assert: tokens size = 3.
	self assert: tokens first = 'abc'.
	self assert: tokens second = 'def'.
	self assert: tokens third = 'ghi'.