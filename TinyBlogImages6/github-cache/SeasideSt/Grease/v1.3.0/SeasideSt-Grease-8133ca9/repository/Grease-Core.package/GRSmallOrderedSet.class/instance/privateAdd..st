private 
privateAdd: newObject
	size = table size ifTrue: [ self grow ].
	table at: (size := size + 1) put: newObject.