public
randomFrom: aCollection
	|random count|
	random := self nextInt: aCollection size.
	^ aCollection isSequenceable
		ifTrue: [ aCollection at: random ]
		ifFalse: [
			count := 1.
			aCollection do: [ :ea |
				count = random ifTrue: [ ^ ea ].
				count := count + 1 ] ]