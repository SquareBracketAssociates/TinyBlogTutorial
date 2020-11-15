private 
findIndexFor: aKey
	1 to: size do: [ :index |
		(table at: index) = aKey
			ifTrue: [ ^ index ] ].
	^ 0