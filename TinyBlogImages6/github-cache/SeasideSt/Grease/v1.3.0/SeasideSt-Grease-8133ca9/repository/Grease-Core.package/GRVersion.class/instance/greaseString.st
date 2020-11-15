converting
greaseString
	^ String streamContents: [ :stream |
		stream nextPutAll: major greaseString.
		stream nextPut: $..
		stream nextPutAll: (minor ifNil: [ 0 ]) greaseString.
		revision isNil ifFalse: [
			stream nextPut: $..
			stream nextPutAll: revision greaseString ].
		stageLabel isNil ifFalse: [
			stream nextPutAll: stageLabel greaseString.
			stageNumber isNil ifFalse: [ stream nextPutAll: stageNumber greaseString ] ] ]