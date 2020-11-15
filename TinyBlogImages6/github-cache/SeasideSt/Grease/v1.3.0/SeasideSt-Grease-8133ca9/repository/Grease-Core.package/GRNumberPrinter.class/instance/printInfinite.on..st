printing
printInfinite: aNumber on: aStream
	infinite isNil
		ifFalse: [ aStream nextPutAll: infinite ]