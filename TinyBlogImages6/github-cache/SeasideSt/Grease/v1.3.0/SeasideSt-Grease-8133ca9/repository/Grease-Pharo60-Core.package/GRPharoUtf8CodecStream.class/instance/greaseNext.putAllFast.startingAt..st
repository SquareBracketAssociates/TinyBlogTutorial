private
greaseNext: anInteger putAllFast: aByteString startingAt: startIndex
	| lastIndex nextIndex |
	lastIndex := startIndex.
	nextIndex := ByteString findFirstInString: aByteString inSet: Latin1ToUtf8Map startingAt: lastIndex.
	nextIndex = 0 ifTrue: [ ^ stream greaseNext: anInteger putAll: aByteString startingAt: startIndex ].
	[	
		nextIndex >= (startIndex + anInteger) ifTrue: [
			^ stream greaseNext: startIndex + anInteger - lastIndex  putAll: aByteString startingAt: lastIndex ].
		nextIndex > lastIndex ifTrue: [
			stream greaseNext: nextIndex - lastIndex putAll: aByteString startingAt: lastIndex ].
		stream nextPutAll: (Latin1ToUtf8Encodings at: (aByteString byteAt: nextIndex) + 1).
		lastIndex := nextIndex + 1.
		nextIndex := ByteString findFirstInString: aByteString inSet: Latin1ToUtf8Map startingAt: lastIndex.
		(nextIndex = 0 or: [ nextIndex >= (startIndex + anInteger) ]) ] whileFalse.
	lastIndex >= (startIndex + anInteger) ifFalse: [
		stream greaseNext: startIndex + anInteger - lastIndex putAll: aByteString startingAt: lastIndex ]