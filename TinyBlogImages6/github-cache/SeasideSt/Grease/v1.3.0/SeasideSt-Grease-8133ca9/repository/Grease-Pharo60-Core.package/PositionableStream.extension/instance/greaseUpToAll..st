*Grease-Pharo60-Core
greaseUpToAll: aCollection 
	"Needed for Seaside ports to other dialects where #upToAll: may have
	different semantics"
	^ self upToAll: aCollection