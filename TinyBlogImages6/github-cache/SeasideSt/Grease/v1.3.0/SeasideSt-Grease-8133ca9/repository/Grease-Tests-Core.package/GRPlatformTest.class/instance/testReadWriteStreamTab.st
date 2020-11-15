tests-streams
testReadWriteStreamTab
	"ANSI 5.9.4.6"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream tab.
	self assert: stream contents first = Character tab