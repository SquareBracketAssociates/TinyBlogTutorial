tests-streams
testWriteStreamNextPut
	"ANSI 5.9.4.3"
	
	| stream |
	stream := WriteStream on: String new.
	stream nextPut: $a.
	self assert: stream contents = 'a'