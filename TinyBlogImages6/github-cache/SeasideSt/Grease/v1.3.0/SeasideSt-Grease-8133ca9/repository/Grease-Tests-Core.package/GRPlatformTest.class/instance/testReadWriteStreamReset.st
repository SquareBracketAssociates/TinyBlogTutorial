tests-streams
testReadWriteStreamReset
	"ANSI 5.9.1.6"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abc';
		reset.
	stream next: 2.
	stream reset.
	self assert: stream next = $a.
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abc';
		reset.
	stream nextPutAll: 'def'.
	self assert: stream contents = 'def'.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abc' asByteArray;
		reset.
	stream next: 2.
	stream reset.
	self assert: stream next = 97