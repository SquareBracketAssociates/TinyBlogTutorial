tests-streams
testReadStreamUpTo
	"ANSI 5.9.2.11"
	
	| stream |
	stream := 'abcd' readStream.
	self assert: (stream upTo: $c) = 'ab'.
	self assert: stream next = $d.
	
	stream := 'abcd' readStream.
	self assert: (stream upTo: $x) = 'abcd'.
	self assert: stream atEnd