tests-streams
testReadStreamNegativeSkip
	"ANSI does not mention negative values being used with #skip: but we
	believe they work consistently. If not, we need to update our coding
	conventions to make sure we never do this."
	
	| stream position |
	stream := 'abcd' readStream.
	stream next; next.
	position := stream position.
	self assert: (stream peek) = $c.
	stream skip: -1.
	self assert: stream position = (position - 1).
	self assert: (stream peek) = $b