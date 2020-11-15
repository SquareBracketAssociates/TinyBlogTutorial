tests-streams
testReadWriteStreamPosition
	"ANSI 5.9.1.4 and 5.9.1.5"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abc';
		reset.
	self assert: stream position = 0.
	stream next.
	self assert: stream position = 1.
	stream next.
	self assert: stream position = 2.
	stream next.
	self assert: stream position = 3.
	stream position: 1.
	self assert: stream position = 1.
	self assert: stream next = $b.
	stream position: 0.
	self assert: stream position = 0.
	self assert: stream next = $a.
	stream position: 3.
	self assert: stream atEnd.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abc' asByteArray;
		reset.
	self assert: stream position = 0.
	stream next.
	self assert: stream position = 1.
	stream next.
	self assert: stream position = 2.
	stream next.
	self assert: stream position = 3.
	stream position: 1.
	self assert: stream position = 1.
	self assert: stream next = 98.
	stream position: 0.
	self assert: stream position = 0.
	self assert: stream next = 97.
	stream position: 3.
	self assert: stream atEnd