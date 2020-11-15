tests-streams
testReadStreamContents
	"ANSI 5.9.3.1"
	
	| stream |
	stream := 'abc' readStream.
	self assert: stream contents = 'abc'.
	stream next: 2.
	self assert: stream contents = 'abc'