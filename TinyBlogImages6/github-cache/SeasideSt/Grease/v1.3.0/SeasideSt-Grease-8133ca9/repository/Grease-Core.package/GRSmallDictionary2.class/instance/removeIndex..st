private
removeIndex: index
	| value |
	value := table at: index * 2.
	index to: size * 2 - 2 do: [ :i | 
		table at: i put: (table at: i + 2) ].
	table at: size * 2 - 1 put: nil.
	table at: size * 2 put: nil.
	size := size - 1.
	^ value