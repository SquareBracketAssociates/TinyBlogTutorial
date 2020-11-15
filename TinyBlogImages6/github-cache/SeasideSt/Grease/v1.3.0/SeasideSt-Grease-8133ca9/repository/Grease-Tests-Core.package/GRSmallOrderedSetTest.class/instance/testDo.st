testing
testDo
	| seen |
	collection addAll: #(2 1 1).
	seen := Array streamContents: [ :stream |
		collection do: [ :each |
			stream nextPut: each ] ].
	self assert: seen size = 2.
	self assert: (seen at: 1) = 2.
	self assert: (seen at: 2) = 1