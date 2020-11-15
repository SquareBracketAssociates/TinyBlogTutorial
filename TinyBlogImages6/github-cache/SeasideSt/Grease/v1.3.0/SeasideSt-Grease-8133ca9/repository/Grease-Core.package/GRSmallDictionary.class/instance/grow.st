private
grow
	| newKeys newValues |
	newKeys := Array new: 2 * size.
	newValues := Array new: 2 * size.
	1 to: size do: [ :index |
		newKeys at: index put: (keys at: index).
		newValues at: index put: (values at: index) ].
	keys := newKeys.
	values := newValues