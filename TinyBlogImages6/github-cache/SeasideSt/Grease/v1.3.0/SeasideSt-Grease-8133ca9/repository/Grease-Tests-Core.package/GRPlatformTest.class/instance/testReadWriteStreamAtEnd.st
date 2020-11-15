tests-streams
testReadWriteStreamAtEnd
	"ANSI 5.9.2.1"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	self assert: stream atEnd.
	stream
		nextPut: $a;
		reset.
	self deny: stream atEnd