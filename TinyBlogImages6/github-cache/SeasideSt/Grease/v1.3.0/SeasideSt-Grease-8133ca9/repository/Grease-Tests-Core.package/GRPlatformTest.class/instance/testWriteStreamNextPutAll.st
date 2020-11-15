tests-streams
testWriteStreamNextPutAll
	"ANSI 5.9.4.4"
	
	| stream |
	stream := WriteStream on: String new.
	stream nextPutAll: 'abc'.
	self assert: stream contents = 'abc'.
	
	stream := WriteStream on: String new.
	stream nextPutAll: #($a $b $c).
	self assert: stream contents = 'abc'