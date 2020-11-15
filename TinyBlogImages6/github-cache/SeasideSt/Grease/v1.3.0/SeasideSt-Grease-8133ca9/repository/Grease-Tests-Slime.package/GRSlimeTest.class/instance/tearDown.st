running
tearDown
	super tearDown.
	(Smalltalk organization listAtCategoryNamed: self category) do:[ :e | 
		SmalltalkImage current removeClassNamed: e ].
	Smalltalk organization
		removeCategory: self category