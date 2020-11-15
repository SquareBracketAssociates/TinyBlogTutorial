tests-utilites
testPadCenter
	| converter |
	converter := GRPrinter new.
	self assert: (converter 
			pad: ''
			center: $*
			to: 3) = '***'.
	self assert: (converter 
			pad: '1'
			center: $*
			to: 3) = '*1*'.
	self assert: (converter 
			pad: '12'
			center: $*
			to: 3) = '12*'.
	self assert: (converter 
			pad: '123'
			center: $*
			to: 3) = '123'.
	self assert: (converter 
			pad: '1234'
			center: $*
			to: 3) = '1234'