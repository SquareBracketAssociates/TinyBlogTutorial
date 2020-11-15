asserting
assert: aCollection sortedWith: sortBlock
	"Assert that aCollection is correctly sorted according to sortBlock."

	1 to: aCollection size -1 do: [ :index |
		| a b |
		a := aCollection at: index.
		b := aCollection at: index + 1.
		self assert: ((sortBlock value: a value: b) or: [ (sortBlock value: b value: a) not ]) ]