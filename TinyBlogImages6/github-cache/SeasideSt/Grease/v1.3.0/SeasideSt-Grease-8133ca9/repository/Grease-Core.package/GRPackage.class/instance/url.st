accessing
url
	"Answer the base-URL of the package. This string is only meaningful for platforms that can directly access Monticello repositories."

	^ url isSymbol
		ifTrue: [ self perform: url ]
		ifFalse: [ url ]