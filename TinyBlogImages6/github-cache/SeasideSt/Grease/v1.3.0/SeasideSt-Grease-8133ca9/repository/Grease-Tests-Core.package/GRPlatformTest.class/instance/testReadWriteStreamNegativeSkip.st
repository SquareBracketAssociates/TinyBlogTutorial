tests-streams
testReadWriteStreamNegativeSkip
	"ANSI does not mention negative values being used with #skip: but we
	believe they work consistently. If not, we need to update our coding
	conventions to make sure we never do this."
	| stream position |
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abcd';
		reset.
	stream
		next;
		next.
	position := stream position.
	self assert: stream peek = $c.
	stream skip: -1.
	self assert: stream position = (position - 1).
	self assert: stream peek = $b.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abcd' asByteArray;
		reset.
	stream
		next;
		next.
	position := stream position.
	self assert: stream peek = 99.
	stream skip: -1.
	self assert: stream position = (position - 1).
	self assert: stream peek = 98