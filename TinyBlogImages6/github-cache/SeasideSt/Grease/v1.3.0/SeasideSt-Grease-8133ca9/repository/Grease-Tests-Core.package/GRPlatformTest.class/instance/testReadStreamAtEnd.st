tests-streams
testReadStreamAtEnd
	"ANSI 5.9.2.1"
	
	| stream |
	stream := '' readStream.
	self assert: stream atEnd.

	stream := 'a' readStream.
	self deny: stream atEnd