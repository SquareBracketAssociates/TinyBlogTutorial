tests-streams
testReadWriteStreamSkip
	"ANSI 5.9.2.9"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abcd';
		reset.
	self assert: (stream
			skip: 2;
			peek) = $c.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abcd' asByteArray;
		reset.
	self assert: (stream
			skip: 2;
			peek) = 99