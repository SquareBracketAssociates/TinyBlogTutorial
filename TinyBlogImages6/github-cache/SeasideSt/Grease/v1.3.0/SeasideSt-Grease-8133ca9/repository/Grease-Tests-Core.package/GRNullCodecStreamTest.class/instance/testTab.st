tests-characters
testTab
	| stream |
	stream := GRNullCodec new 
		encoderFor: (WriteStream on: String new).
	stream tab.
	
	self assert: stream contents size = 1.
	self assert: stream contents first = Character tab