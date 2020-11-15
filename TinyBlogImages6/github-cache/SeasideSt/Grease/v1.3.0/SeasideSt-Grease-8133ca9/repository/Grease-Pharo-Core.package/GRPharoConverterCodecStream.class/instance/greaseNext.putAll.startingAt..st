streaming
greaseNext: anInteger putAll: aCollection startingAt: startIndex
	self nextPutAll: (aCollection copyFrom: startIndex to: startIndex + anInteger - 1)