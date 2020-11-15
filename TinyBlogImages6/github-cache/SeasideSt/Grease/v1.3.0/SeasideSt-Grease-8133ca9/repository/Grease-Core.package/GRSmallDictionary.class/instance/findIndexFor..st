private
findIndexFor: aKey
	1 to: size do: [ :index |
		(keys at: index) = aKey
			ifTrue: [ ^ index ] ].
	^ 0