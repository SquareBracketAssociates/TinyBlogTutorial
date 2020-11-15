tests
testDigitValue
	'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ' 
		with: (0 to: 35)
		do: [ :each :expected | self assert: each digitValue = expected ]