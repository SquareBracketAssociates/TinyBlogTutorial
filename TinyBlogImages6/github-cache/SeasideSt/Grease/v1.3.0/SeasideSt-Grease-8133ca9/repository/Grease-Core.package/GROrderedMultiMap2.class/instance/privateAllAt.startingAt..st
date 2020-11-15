private 
privateAllAt: aKey startingAt: index
	^ Array new: 2 streamContents: [ :stream |
		index to: size * 2 - 1 by: 2 do: [ :i |
			(table at: i) = aKey
				ifTrue: [ stream nextPut: (table at: i + 1) ] ] ]