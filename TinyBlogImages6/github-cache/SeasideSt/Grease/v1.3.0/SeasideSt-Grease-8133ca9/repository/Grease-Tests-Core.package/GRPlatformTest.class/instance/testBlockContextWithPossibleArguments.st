tests
testBlockContextWithPossibleArguments
	| block |
	block := [ :x | 1 + x ].
	self assert: (block valueWithPossibleArguments: (Array with: 2)) = 3.

	block := [ false not ].
	self assert: (block valueWithPossibleArguments: (Array with: 3))