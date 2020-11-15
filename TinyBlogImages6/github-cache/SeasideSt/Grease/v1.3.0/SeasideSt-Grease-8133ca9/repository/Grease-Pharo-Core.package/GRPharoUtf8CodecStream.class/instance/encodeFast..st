private
encodeFast: aByteString
	"Convert the given string from UTF-8 using the fast path if converting to Latin-1"
	| lastIndex nextIndex |
	lastIndex := 1.
	nextIndex := ByteString findFirstInString: aByteString inSet: Latin1ToUtf8Map startingAt: lastIndex.
	nextIndex = 0 ifTrue: [ ^ stream nextPutAll: aByteString ].
	[	nextIndex > lastIndex ifTrue: [
			stream greaseNext: nextIndex - lastIndex putAll: aByteString startingAt: lastIndex ].
		stream nextPutAll: (Latin1ToUtf8Encodings at: (aByteString byteAt: nextIndex) + 1).
		lastIndex := nextIndex + 1.
		nextIndex := ByteString findFirstInString: aByteString inSet: Latin1ToUtf8Map startingAt: lastIndex.
		nextIndex = 0 ] whileFalse.
	stream greaseNext: aByteString size - lastIndex + 1 putAll: aByteString startingAt: lastIndex