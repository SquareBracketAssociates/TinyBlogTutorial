accessing
at: aKey put: aValue
	"Set the value of aKey to be aValue."

	| index |
	index := self findIndexFor: aKey.
	^ index = 0
		ifFalse: [ table at: index + 1 put: aValue ]
		ifTrue: [ self privateAt: aKey put: aValue ]