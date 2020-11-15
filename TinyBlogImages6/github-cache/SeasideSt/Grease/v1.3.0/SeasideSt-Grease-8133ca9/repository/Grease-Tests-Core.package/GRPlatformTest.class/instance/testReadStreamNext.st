tests-streams
testReadStreamNext
	"ANSI 5.9.2.3"
	
	| stream |
	stream := 'abcd' readStream.
	self assert: stream next = $a.
	self assert: (stream next: 0) = ''.
	self assert: (stream next: 1) = 'b'.
	self assert: (stream next: 2) = 'cd'