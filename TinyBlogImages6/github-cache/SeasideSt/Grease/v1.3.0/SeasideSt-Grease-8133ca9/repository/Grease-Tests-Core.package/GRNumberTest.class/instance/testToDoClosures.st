tests
testToDoClosures
	"#to:do: may be optimized and VAST currently has problems with closures
	in this case. We would prefer to use the optimized version than than
	(1 to: 5) do: [ ... ] so this test is here to highlight the problem at
	least unless the platforms tell us the problem is not fixable."
	
	| collection |
	collection := OrderedCollection new.
	1 to: 5 do: [ :each | collection add: [ each ] fixCallbackTemps ].
	self assert: (collection collect: [ :each | each value ]) asArray = #(1 2 3 4 5)