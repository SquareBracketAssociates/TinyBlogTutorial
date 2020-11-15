utilities
pad: aString right: aCharacter to: anInteger
	"Pad to the right side of aString with aCharacter to at least anInteger characters."

	| result |
	anInteger <= aString size
		ifTrue: [ ^ aString ].
	result := (String new: anInteger) atAllPut: aCharacter.
	result
		replaceFrom: 1
		to: aString size
		with: aString
		startingAt: 1.
	^ result