tests-streams
testWriteStreamCrLf
	| stream |
	stream := WriteStream on: String new.
	stream crlf.
	self assert: stream contents first codePoint = 13.
	self assert: stream contents second codePoint = 10