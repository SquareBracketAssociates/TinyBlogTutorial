tests-streams
testReadWriteStreamPeek
	"ANSI 5.9.2.7"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	self assert: stream peek isNil.
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abcd';
		reset.
	self assert: stream peek = $a.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abcd' asByteArray;
		reset.
	self assert: stream peek = 97