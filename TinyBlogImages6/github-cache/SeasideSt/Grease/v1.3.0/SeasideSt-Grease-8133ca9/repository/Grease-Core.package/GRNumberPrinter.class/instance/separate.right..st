utilities
separate: aString right: aCharacter
	"Separate from the right side every 3 characters with aCharacter."
		
	| size stream |
	size := aString size.
	stream := WriteStream on: (String new: 2 * size).
	1 to: size do: [ :index |
		(index ~= 1 and: [ size - index \\ 3 = 2 ])
			ifTrue: [ stream nextPut: aCharacter ].
		stream nextPut: (aString at: index) ].
	^ stream contents