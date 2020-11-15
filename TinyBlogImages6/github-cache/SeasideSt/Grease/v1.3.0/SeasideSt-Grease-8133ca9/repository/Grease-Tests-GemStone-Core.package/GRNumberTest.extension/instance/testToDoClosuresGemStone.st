*grease-tests-gemstone-core
testToDoClosuresGemStone
	"workaround for non-ANSI compliance"
	
	| collection |
	collection := OrderedCollection new.
	1 to: 5 do: [ :ea | self addBlockToCollection: collection with: ea ].
	self assert: (collection collect: [ :ea | ea value ]) asArray = #(1 2 3 4 5)