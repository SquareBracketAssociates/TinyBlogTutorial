accessing
allAt: aKey
	^ Array streamContents: [ :stream |
		1 to: size do: [ :index |
			(keys at: index) = aKey
				ifTrue: [ stream nextPut: (values at: index) ] ] ]