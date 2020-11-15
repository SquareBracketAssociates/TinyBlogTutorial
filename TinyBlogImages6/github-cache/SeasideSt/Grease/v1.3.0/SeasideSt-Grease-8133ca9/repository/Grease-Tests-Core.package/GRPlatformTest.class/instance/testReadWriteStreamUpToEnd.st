tests-streams
testReadWriteStreamUpToEnd
	"Not defined by ANSI."
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abcd';
		reset.
	self assert: stream upToEnd = 'abcd'.
	self assert: stream atEnd.
	self assert: stream upToEnd = ''.
	self assert: stream atEnd.
	stream reset.
	stream upTo: $b.
	self assert: stream upToEnd = 'cd'.
	self assert: stream atEnd.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abcd' asByteArray;
		reset.
	self assert: stream upToEnd = #(97 98 99 100 ) asByteArray.
	self assert: stream atEnd.
	self assert: stream upToEnd = #() asByteArray.
	self assert: stream atEnd.
	stream reset.
	stream upTo: 98.
	self assert: stream upToEnd = #(99 100 ) asByteArray.
	self assert: stream atEnd