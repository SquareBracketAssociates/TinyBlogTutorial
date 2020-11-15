tests-streams
testReadWriteStreamNextPut
	"ANSI 5.9.4.3"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream nextPut: $a.
	self assert: stream contents = 'a'.
	stream := GRPlatform current readWriteByteStream.
	stream nextPut: 97.
	self assert: stream contents = 'a' asByteArray