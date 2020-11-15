tests-converting
testCapitalized
	self assert: 'capitalized' capitalized = 'Capitalized'.
	self assert: 'Capitalized' capitalized = 'Capitalized'.
	self assert: 'CAPITALIZED' capitalized = 'CAPITALIZED'.
	self assert: #'capitalized' capitalized = #'Capitalized'.
	self assert: #'Capitalized' capitalized = #'Capitalized'.
	self assert: #'CAPITALIZED' capitalized = #'CAPITALIZED'