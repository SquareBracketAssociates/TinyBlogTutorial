utilities
digitsOf: aNumber base: aBaseInteger
	"Answer the absolute digits of aNumber in the base aBaseInteger."

	| integer stream next |
	integer := aNumber truncated abs.
	integer = 0 ifTrue: [ ^ '0' ].
	stream := WriteStream on: (String new: 10).
	[ integer > 0 ] whileTrue: [
		next := integer quo: aBaseInteger.
		stream nextPut: (characters 
			at: 1 + integer - (next * aBaseInteger)).
		integer := next ].
	^ stream contents reverse