tests-utilites
testPadRight
	| converter |
	converter := GRPrinter new.
	self assert: (converter 
			pad: ''
			right: $*
			to: 3) = '***'.
	self assert: (converter 
			pad: '1'
			right: $*
			to: 3) = '1**'.
	self assert: (converter 
			pad: '12'
			right: $*
			to: 3) = '12*'.
	self assert: (converter 
			pad: '123'
			right: $*
			to: 3) = '123'.
	self assert: (converter 
			pad: '1234'
			right: $*
			to: 3) = '1234'