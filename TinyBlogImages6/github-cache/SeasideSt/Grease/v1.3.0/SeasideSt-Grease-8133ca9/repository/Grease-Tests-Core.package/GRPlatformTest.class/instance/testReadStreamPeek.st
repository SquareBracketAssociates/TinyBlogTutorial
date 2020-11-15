tests-streams
testReadStreamPeek
	"ANSI 5.9.2.7"
	
	| stream |
	stream := 'abcd' readStream.
	self assert: stream peek = $a.
	
	stream := '' readStream.
	self assert: stream peek isNil