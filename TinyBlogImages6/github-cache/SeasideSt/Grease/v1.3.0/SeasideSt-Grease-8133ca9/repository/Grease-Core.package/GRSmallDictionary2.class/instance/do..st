enumerating
do: aBlock
	2 to: size * 2 by: 2 do: [ :index |
		aBlock value: (table at: index) ]