*grease-core
greaseInteger
	"Convert the receiver to an integer, answer nil if this is not a number."
	| number negated |
	number := nil.
	negated := false.
	1 to: self size do: [ : i |
		| char |
		char := self at: i.
		(i = 1 and: [ char = $- ])
			ifTrue: [ negated := true ]
			ifFalse: [
				(char >= $0 and: [ char <= $9 ])
					ifTrue: [
						number := (number isNil
							ifTrue: [ 0 ]
							ifFalse: [ 10 * number ]) + (char greaseInteger - $0 greaseInteger) ]
					ifFalse: [
						^ number isNil ifFalse: [ 
							 negated not
								ifFalse: [ number negated ]
								ifTrue: [ number ] ] ] ] ].
	^ number isNil ifFalse: [
		negated not
			ifFalse: [ number negated ]
			ifTrue: [ number ] ]