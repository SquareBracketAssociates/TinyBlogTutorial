enumerating
do: aBlock
	1 to: size do: [ :index | aBlock value: (values at: index) ]