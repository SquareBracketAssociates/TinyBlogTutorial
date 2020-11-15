enumerating
keysDo: aBlock
	1 to: size do: [ :each | aBlock value: (keys at: each) ]