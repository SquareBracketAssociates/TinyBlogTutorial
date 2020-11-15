utilities
pad: aString center: aCharacter to: anInteger
	"Pad to the center of aString with aCharacter to at least anInteger characters."

	| result index |
	anInteger <= aString size
		ifTrue: [ ^ aString ].
	index := (anInteger - aString size) // 2.
	result := (String new: anInteger) atAllPut: aCharacter.
	result
		replaceFrom: index + 1
		to: index + aString size
		with: aString
		startingAt: 1.
	^ result