*grease-core
excerpt: aString radius: anInteger ellipsis: anEllipsisString
	"Answer an excerpt of the receiver that matches the first occurence of aString. The radius anInteger expands the excerpt on each side of the first occurrence by the number of characters defined in radius. If aString isn't found, nil is answered."

	| index start stop |
	(index := self indexOfSubCollection: aString) = 0
		ifTrue: [ ^ nil ].
	start := index - anInteger max: 1.
	stop := index + anInteger + aString size - 1 min: self size.
	^ (start > 1 ifTrue: [ anEllipsisString ] ifFalse: [ '' ]) ,
		(self copyFrom: start to: stop) ,
	  	(stop < self size ifTrue: [ anEllipsisString ] ifFalse: [ '' ])