*grease-core
pluralize: aSingularString 
	^ self 
		pluralize: aSingularString
		with: (GRInflector pluralize: aSingularString)