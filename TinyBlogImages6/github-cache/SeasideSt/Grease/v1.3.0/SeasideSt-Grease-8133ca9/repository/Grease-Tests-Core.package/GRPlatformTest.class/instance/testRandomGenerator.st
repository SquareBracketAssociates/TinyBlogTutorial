tests-streams
testRandomGenerator
	| generator collection |
	generator := self platform newRandom.
	self should: [ generator nextInt: 0 ] raise: Error.
	self assert: (generator nextInt: 1) = 1.
	collection := (1 to: 200) collect: [ :ea | generator nextInt: 2 ].
	self assert: (collection includes: 1).
	self assert: (collection includes: 2).
	self assert: collection asSet size = 2.

	collection := 1 to: 5.
	self assert: (collection includes: (generator randomFrom: collection)).
	collection := -1.5 to: 3.5.
	self assert: (collection includes: (generator randomFrom: collection)).
	collection := #(1 2 3 4 5).
	self assert: (collection includes: (generator randomFrom: collection)).
	collection := #(1 2 3 4 5) asSet.
	self assert: (collection includes: (generator randomFrom: collection))