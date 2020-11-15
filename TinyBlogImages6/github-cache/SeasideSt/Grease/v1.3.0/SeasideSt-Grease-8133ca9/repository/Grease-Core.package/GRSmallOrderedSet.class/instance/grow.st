private 
grow
	| newTable |
	"#replaceFrom:to:with:startingAt: would be better but not portable"
	newTable := Array new: 2 * size.
	1 to: size do: [ :index |
		newTable at: index put: (table at: index) ].
	table := newTable