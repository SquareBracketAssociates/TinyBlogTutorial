enumerating
values
	| values i |
	size = 0 ifTrue: [ ^ #() ].
	i := 1.
	values := Array new: size.
	2 to: size * 2 by: 2 do: [ :index |
		values at: i put: (table at: index).
		i := i + 1 ].
	^ values