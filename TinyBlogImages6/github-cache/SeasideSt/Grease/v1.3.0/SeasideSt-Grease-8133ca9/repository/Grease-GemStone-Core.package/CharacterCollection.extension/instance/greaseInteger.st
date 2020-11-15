*grease-gemstone-core
greaseInteger
	"Convert the receiver to an integer, answer nil if this is not a number."
	| number stream negated char |
	number := nil.
	stream := self readStream.
	negated := stream peek = $-.
	negated ifTrue: [ stream next ].
	[ stream atEnd not and: [ (char := stream next) isDigit ] ] whileTrue: [
		number := (number isNil  ifTrue: [ 0 ]ifFalse: [ 10 * number ])
			+ (char greaseInteger - $0 greaseInteger) ].
	^ (number isNil or: [ negated not ]) 
		ifFalse: [ number negated ]
		ifTrue: [ number ]