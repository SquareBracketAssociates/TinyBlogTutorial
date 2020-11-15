printing
printNaN: anInteger on: aStream
	nan isNil
		ifFalse: [ aStream nextPutAll: nan ]