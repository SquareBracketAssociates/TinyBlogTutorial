*grease-squeak5-core
valueWithPossibleArguments: anArray
	| args |
	(anArray size == self numArgs)
		ifTrue: [ ^ self valueWithArguments: anArray ].
	args := Array new: self numArgs.
	args replaceFrom: 1
		to: (anArray size min: args size)
		with: anArray
		startingAt: 1.
	^ self valueWithArguments: args