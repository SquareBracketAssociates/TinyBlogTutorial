private
findIndexFor: aKey
	1 to: size * 2 - 1 by: 2 do: [ :index |
		(table at: index) = aKey
			ifTrue: [ ^ index ] ].
	^ 0