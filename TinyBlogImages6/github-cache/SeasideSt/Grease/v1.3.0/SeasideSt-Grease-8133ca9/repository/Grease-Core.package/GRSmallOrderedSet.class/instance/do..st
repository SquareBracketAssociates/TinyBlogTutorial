enumerating
do: aOneArgumentBlock
	1 to: size do: [ :i |
		aOneArgumentBlock value: (table at: i) ]