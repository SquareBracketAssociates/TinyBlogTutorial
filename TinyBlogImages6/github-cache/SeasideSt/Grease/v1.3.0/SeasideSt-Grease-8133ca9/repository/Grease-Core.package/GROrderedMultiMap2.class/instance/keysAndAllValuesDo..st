enumerating
keysAndAllValuesDo: aTwoArgumentBlock
	| seenKeys |
	seenKeys := GRSmallOrderedSet new.
	1 to: size * 2 - 1 by: 2 do: [ :index |
		| key |
		key := table at: index.
		(seenKeys includes: key) ifFalse: [
			aTwoArgumentBlock
				value: key
				value: (self privateAllAt: key startingAt: index).
			seenKeys add: key ] ]