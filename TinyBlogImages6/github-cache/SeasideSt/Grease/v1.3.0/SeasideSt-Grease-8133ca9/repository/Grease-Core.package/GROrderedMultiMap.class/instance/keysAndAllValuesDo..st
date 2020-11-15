enumerating
keysAndAllValuesDo: aTwoArgumentBlock
	| seenKeys |
	seenKeys := GRSmallOrderedSet new.
	1 to: size do: [ :index |
		| key |
		key := keys at: index.
		(seenKeys includes: key) ifFalse: [
			aTwoArgumentBlock
				value: key
				value: (self privateAllAt: key startingAt: index).
			seenKeys add: key ] ]