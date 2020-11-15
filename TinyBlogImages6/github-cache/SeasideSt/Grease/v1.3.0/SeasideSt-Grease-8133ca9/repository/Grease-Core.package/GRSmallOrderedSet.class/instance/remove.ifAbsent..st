removing
remove: anObject ifAbsent: aNiladicBlock
	| index |
	index := self findIndexFor: anObject.
	index = 0
		ifTrue: [ ^ aNiladicBlock value ]
		ifFalse: [ self removeIndex: index ].
	^ anObject