tests-streams
testWriteStreamPosition
	| stream |
	stream := GRPlatform current writeCharacterStreamOn: String new.
	self assert: stream position = 0.
	stream nextPutAll: 'abc'.
	self assert: stream position = 3.
	stream reset.
	self assert: stream position = 0