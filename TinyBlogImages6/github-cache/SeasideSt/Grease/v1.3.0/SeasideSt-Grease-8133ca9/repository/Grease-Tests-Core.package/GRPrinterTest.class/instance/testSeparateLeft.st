tests-utilites
testSeparateLeft
	| converter |
	converter := GRNumberPrinter new.
	self assert: (converter 
			separate: ''
			left: $*) = ''.
	self assert: (converter 
			separate: '1'
			left: $*) = '1'.
	self assert: (converter 
			separate: '12'
			left: $*) = '12'.
	self assert: (converter 
			separate: '123'
			left: $*) = '123'.
	self assert: (converter 
			separate: '1234'
			left: $*) = '123*4'.
	self assert: (converter 
			separate: '12345'
			left: $*) = '123*45'.
	self assert: (converter 
			separate: '123456'
			left: $*) = '123*456'.
	self assert: (converter 
			separate: '1234567'
			left: $*) = '123*456*7'.
	self assert: (converter 
			separate: '12345678'
			left: $*) = '123*456*78'.
	self assert: (converter 
			separate: '123456789'
			left: $*) = '123*456*789'