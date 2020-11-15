tests-streams
testReadStreamSkip
	"ANSI 5.9.2.9"
	
	| stream |
	stream := 'abcd' readStream.
	self assert: (stream skip: 2; peek) = $c