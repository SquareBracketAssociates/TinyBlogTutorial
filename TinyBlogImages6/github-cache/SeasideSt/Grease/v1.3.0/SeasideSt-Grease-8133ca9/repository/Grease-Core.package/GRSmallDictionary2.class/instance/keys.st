enumerating
keys
	| keys i |
	size = 0 ifTrue: [ ^ #() ].
	i := 1.
	keys := Array new: size.
	1 to: size * 2 - 1 by: 2 do: [ :index |
		keys at: i put: (table at: index).
		i := i + 1 ].
	^ keys