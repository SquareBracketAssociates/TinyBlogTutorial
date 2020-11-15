*grease-core
pluralize: aSingularString with: aPluralString
	^ self printString , ' ' , (self abs = 1 ifTrue: [ aSingularString ] ifFalse: [ aPluralString ])