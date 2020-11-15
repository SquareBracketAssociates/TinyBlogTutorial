tests-streams
testWriteStreamReset
	"ANSI 5.9.1.6"
	
	| stream |
	stream := WriteStream on: String new.
	stream nextPutAll: 'abc'.
	stream reset.
	stream nextPutAll: 'def'.
	self assert: stream contents = 'def'