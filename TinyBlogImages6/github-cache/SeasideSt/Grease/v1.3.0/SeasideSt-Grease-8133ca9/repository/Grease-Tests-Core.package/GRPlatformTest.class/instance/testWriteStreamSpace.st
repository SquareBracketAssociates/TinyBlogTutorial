tests-streams
testWriteStreamSpace
	"ANSI 5.9.4.5"
	
	| stream |
	stream := WriteStream on: String new.
	stream space.
	self assert: stream contents first = Character space