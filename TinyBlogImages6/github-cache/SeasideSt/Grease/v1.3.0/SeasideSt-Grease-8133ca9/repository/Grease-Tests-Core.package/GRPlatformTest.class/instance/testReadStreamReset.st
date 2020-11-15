tests-streams
testReadStreamReset
	"ANSI 5.9.1.6"
	
	| stream |
	stream := 'abc' readStream.
	stream next: 2.
	stream reset.
	self assert: stream next = $a