tests-streams
testReadWriteStreamUpTo
	"ANSI 5.9.2.11"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abcd';
		reset.
	self assert: (stream upTo: $c) = 'ab'.
	self assert: stream next = $d.
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abcd';
		reset.
	self assert: (stream upTo: $x) = 'abcd'.
	self assert: stream atEnd.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abcd' asByteArray;
		reset.
	self assert: (stream upTo: 99) = #(97 98 ) asByteArray.
	self assert: stream next = 100.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abcd' asByteArray;
		reset.
	self assert: (stream upTo: 120) = #(97 98 99 100 ) asByteArray.
	self assert: stream atEnd