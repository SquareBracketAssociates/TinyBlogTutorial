private
privateAllAt: aKey startingAt: aStartInteger
	^ Array new: 2 streamContents: [ :stream |
		aStartInteger to: size do: [ :index |
			(keys at: index) = aKey
				ifTrue: [ stream nextPut: (values at: index) ] ] ]