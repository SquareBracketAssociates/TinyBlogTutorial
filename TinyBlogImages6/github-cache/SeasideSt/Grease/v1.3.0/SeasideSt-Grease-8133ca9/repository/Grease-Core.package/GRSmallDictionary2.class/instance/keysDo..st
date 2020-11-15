enumerating
keysDo: aBlock
	1 to: size * 2 - 1 by: 2 do: [ :index |
			aBlock value: (table at: index) ]