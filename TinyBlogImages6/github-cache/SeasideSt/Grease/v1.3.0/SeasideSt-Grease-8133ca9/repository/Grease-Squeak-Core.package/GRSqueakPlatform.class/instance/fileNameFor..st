file library
fileNameFor: aPathString
	| path |
	path := FileDirectory default fullPathFor: aPathString.
	^ (path size > 1 and: [ path endsWith: FileDirectory slash ])
		ifTrue: [ path allButLast: FileDirectory slash size ]
		ifFalse: [ path ]