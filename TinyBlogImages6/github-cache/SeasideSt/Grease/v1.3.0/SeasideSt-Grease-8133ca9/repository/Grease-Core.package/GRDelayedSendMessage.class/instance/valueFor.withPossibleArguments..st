delegation
valueFor: receiver withPossibleArguments: anArray
	"Send the message to receiver with as many of the arguments in anArray as possible. Answer the result.
	Error if not enough arguments are available for the selector."

	| allArguments |
	allArguments := self mergeArguments: anArray.
	
	^ allArguments size < selector numArgs
		ifTrue: [ self invalidArgumentCount ]
		ifFalse: [ self basicPerformFor: receiver withArguments: (allArguments first: selector numArgs) ]