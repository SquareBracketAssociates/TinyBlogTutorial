private 
removeIndex: index
	table at: index put: nil.
	index to: size - 1 do: [ :i |
		table at: i put: (table at: i + 1) ].
	size := size - 1