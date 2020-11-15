accessing
at: aKey ifAbsentPut: aBlock
	"Answer the value associated with aKey. Evaluate aBlock, if no such key is defined and store the return value."

	| index |
	index := self findIndexFor: aKey.
	^ index = 0
		ifFalse: [ table at: index + 1 ]
		ifTrue: [ self privateAt: aKey put: aBlock value ]