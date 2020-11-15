streaming
greaseNext: anInteger putAll: aCollection startingAt: startIndex
	aCollection isByteString
		ifTrue: [ self greaseNext: anInteger putAllFast: aCollection startingAt: startIndex ]
		ifFalse: [ super greaseNext: anInteger putAll: aCollection startingAt: startIndex ]