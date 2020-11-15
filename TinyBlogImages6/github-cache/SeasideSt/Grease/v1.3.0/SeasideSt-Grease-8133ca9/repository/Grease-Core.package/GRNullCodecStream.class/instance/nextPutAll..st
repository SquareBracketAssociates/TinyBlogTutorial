streaming
nextPutAll: aStringOrByteArray
	aStringOrByteArray isString
		ifTrue: [ stream nextPutAll: aStringOrByteArray ]
		ifFalse: [
			1 to: aStringOrByteArray size do: [ :index |
				stream nextPut: (Character codePoint: (aStringOrByteArray at: index)) ] ]