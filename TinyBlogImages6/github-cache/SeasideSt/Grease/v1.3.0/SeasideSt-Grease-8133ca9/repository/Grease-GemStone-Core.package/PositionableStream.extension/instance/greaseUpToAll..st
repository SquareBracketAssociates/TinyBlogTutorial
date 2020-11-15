*grease-gemstone-core
greaseUpToAll: aCollection
	"Needed for Seaside ports to other dialects where #upToAll: may have
	different semantics"

	| result |
	result := self upToAll: aCollection.
	self atEnd not ifTrue: [self skip: aCollection size].
	^result.