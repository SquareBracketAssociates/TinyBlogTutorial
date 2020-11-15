tests-streams-seaside
testReadStreamSeasideUpToAll
	| stream string1 string2 |
	stream := 'abc12def' readStream.
	string1 := stream greaseUpToAll: '12'.
	string2 := stream greaseUpToAll: '12'.
	self assert: string1 = 'abc'.
	self assert: string2 = 'def'.
	self assert: stream atEnd