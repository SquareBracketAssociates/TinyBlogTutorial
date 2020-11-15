tests-streams
testWriteStreamTab
	"ANSI 5.9.4.6"
	
	| stream |
	stream := WriteStream on: String new.
	stream tab.
	self assert: stream contents first = Character tab