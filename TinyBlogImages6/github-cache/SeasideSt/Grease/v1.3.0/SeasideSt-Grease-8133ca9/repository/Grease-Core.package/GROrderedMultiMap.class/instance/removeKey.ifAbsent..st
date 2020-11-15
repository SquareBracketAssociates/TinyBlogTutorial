accessing
removeKey: aKey ifAbsent: aBlock
	"Remove aKey from the receiver, evaluate aBlock if the element is missing."

	"This is inefficient and could be optimized."
	| removed |
	removed := Array new: 2 streamContents: [ :stream |
		| index |
		[ (index := self findIndexFor: aKey) = 0 ] whileFalse: [
			stream nextPut: (self removeIndex: index) ] ].
	^ removed isEmpty
		ifTrue: [ aBlock value ]
		ifFalse: [ removed ]