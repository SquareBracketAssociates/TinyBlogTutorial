enumerating
keysAndValuesDo: aBlock
	1 to: size do: [ :index | aBlock value: (keys at: index) value: (values at: index) ]