adding
add: newObject
	(self findIndexFor: newObject) = 0
		ifTrue: [ self privateAdd: newObject ].
	^ newObject