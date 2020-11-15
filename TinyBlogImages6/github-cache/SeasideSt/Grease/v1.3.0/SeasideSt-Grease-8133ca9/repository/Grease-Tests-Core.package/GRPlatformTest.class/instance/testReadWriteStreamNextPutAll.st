tests-streams
testReadWriteStreamNextPutAll
	"ANSI 5.9.4.4"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream nextPutAll: 'abc'.
	self assert: stream contents = 'abc'.
	stream := GRPlatform current readWriteCharacterStream.
	stream nextPutAll: #($a $b $c).
	self assert: stream contents = 'abc'.
	stream := GRPlatform current readWriteByteStream.
	stream nextPutAll: #(97 98 99 ) asByteArray.
	self assert: stream contents = 'abc' asByteArray