tests-streams
testWriteStreamContents
	| stream |
	stream := GRPlatform current writeCharacterStreamOn: String new.
	self assert: stream contents = ''.
	stream
		nextPutAll: 'abcdef'.
	self assert: stream contents = 'abcdef'.
	stream
		reset;
		nextPutAll: 'gh'.
	self assert: stream contents = 'gh'