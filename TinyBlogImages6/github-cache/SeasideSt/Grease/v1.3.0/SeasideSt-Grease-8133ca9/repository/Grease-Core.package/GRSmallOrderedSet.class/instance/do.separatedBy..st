enumerating
do: aOneArgumentBlock separatedBy: aNiladicBlock
	1 to: size do: [ :i |
		i > 1 ifTrue: [ aNiladicBlock value ].
		aOneArgumentBlock value: (table at: i) ]