utilities
pad: aString left: aCharacter to: anInteger
	"Pad to the left side of aString with aCharacter to at least anInteger characters."

	| result |
	anInteger <= aString size
		ifTrue: [ ^ aString ].
	result := (String new: anInteger) atAllPut: aCharacter.
	result
		replaceFrom: anInteger - aString size + 1
		to: anInteger
		with: aString
		startingAt: 1.
	^ result