tests-utilites
testPadLeft
	| converter |
	converter := GRPrinter new.
	self assert: (converter 
			pad: ''
			left: $*
			to: 3) = '***'.
	self assert: (converter 
			pad: '1'
			left: $*
			to: 3) = '**1'.
	self assert: (converter 
			pad: '12'
			left: $*
			to: 3) = '*12'.
	self assert: (converter 
			pad: '123'
			left: $*
			to: 3) = '123'.
	self assert: (converter 
			pad: '1234'
			left: $*
			to: 3) = '1234'