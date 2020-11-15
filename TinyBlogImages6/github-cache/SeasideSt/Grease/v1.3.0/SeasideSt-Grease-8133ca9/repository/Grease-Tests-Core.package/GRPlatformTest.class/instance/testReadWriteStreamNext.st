tests-streams
testReadWriteStreamNext
	"ANSI 5.9.2.3"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abcd';
		reset.
	self assert: stream next = $a.
	self assert: (stream next: 0) = ''.
	self assert: (stream next: 1) = 'b'.
	self assert: (stream next: 2) = 'cd'.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abcd' asByteArray;
		reset.
	self assert: stream next = 97.
	self assert: (stream next: 0) = '' asByteArray.
	self assert: (stream next: 1) = 'b' asByteArray.
	self assert: (stream next: 2) = 'cd' asByteArray