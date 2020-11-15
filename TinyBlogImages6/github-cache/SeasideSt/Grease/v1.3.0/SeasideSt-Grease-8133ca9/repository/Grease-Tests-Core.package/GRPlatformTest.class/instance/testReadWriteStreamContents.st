tests-streams
testReadWriteStreamContents
	"ANSI 5.9.3.1"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abc';
		reset.
	self assert: stream contents = 'abc'.
	stream next: 2.
	self assert: stream contents = 'abc'.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abc' asByteArray;
		reset.
	self assert: stream contents = 'abc' asByteArray.
	stream next: 2.
	self assert: stream contents = 'abc' asByteArray