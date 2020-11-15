accessing
pluralize: aString
	| string |
	string := aString asLowercase.
	Uninflected do: [ :each |
		(string endsWithSubCollection: each)
			ifTrue: [ ^ aString ] ].
	InflectionRules do: [ :rule |
		(string endsWithSubCollection: rule first)
			ifTrue: [ ^ (aString allButLast: rule third) , rule second ] ].
	^ aString , 's'