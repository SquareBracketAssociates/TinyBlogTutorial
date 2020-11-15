tests-streams
testReadStreamUpToEnd
	"Not defined by ANSI."
	
	| stream |
	stream := 'abcd' readStream.
	self assert: stream upToEnd = 'abcd'.
	self assert: stream atEnd.
	self assert: stream upToEnd = ''.
	self assert: stream atEnd.
	
	stream := 'abcd' readStream.
	stream upTo: $b.
	self assert: stream upToEnd = 'cd'.
	self assert: stream atEnd