utilities
separate: aString left: aCharacter
	"Separate from the left side every 3 characters with aCharacter."
		
	| size stream |
	size := aString size.
	stream := WriteStream on: (String new: 2 * size).
	1 to: size do: [ :index |
		(index ~= 1 and: [ index \\ 3 = 1 ])
			ifTrue: [ stream nextPut: aCharacter ].
		stream nextPut: (aString at: index) ].
	^ stream contents