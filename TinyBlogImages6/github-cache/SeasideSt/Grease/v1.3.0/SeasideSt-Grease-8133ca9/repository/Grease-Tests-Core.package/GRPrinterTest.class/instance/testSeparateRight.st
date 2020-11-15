tests-utilites
testSeparateRight
	| converter |
	converter := GRNumberPrinter new.
	self assert: (converter 
			separate: ''
			right: $*) = ''.
	self assert: (converter 
			separate: '1'
			right: $*) = '1'.
	self assert: (converter 
			separate: '12'
			right: $*) = '12'.
	self assert: (converter 
			separate: '123'
			right: $*) = '123'.
	self assert: (converter 
			separate: '1234'
			right: $*) = '1*234'.
	self assert: (converter 
			separate: '12345'
			right: $*) = '12*345'.
	self assert: (converter 
			separate: '123456'
			right: $*) = '123*456'.
	self assert: (converter 
			separate: '1234567'
			right: $*) = '1*234*567'.
	self assert: (converter 
			separate: '12345678'
			right: $*) = '12*345*678'.
	self assert: (converter 
			separate: '123456789'
			right: $*) = '123*456*789'