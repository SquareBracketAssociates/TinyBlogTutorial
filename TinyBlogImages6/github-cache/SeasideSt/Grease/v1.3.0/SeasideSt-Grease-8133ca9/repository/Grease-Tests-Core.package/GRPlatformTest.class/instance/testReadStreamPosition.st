tests-streams
testReadStreamPosition
	"ANSI 5.9.1.4 and 5.9.1.5"
	
	| stream |
	stream := 'abc' readStream.
	self assert: stream position = 0.
	stream next.
	self assert: stream position = 1.
	stream next.
	self assert: stream position = 2.
	stream next.
	self assert: stream position = 3.
	
	stream position: 1.
	self assert: stream position = 1.
	self assert: stream next = $b.
	stream position: 0.
	self assert: stream position = 0.
	self assert: stream next = $a.
	stream position: 3.
	self assert: stream atEnd
	