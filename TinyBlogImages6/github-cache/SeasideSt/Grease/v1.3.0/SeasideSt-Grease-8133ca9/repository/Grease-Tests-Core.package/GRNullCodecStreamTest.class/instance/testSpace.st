tests-characters
testSpace
	| stream |
	stream := GRNullCodec new 
		encoderFor: (WriteStream on: String new).
	stream space.
	
	self assert: stream contents size = 1.
	self assert: stream contents first = Character space