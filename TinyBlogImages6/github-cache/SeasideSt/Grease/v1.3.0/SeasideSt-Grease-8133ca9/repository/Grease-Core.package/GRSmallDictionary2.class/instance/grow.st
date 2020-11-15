private
grow
	| newTable |
	"#replaceFrom:to:with:startingAt: would be better but not portable"
	newTable := Array new: 4 * size.
	1 to: size * 2 do: [ :index |
		newTable at: index put: (table at: index) ].
	table := newTable