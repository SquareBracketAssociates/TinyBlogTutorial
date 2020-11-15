delegation
valueFor: receiver withArguments: anArray
	"Send the message to receiver with the arguments in anArray. Answer the result.
	Signal an error if the number of arguments does not match the selector."
	
	^ self basicPerformFor: receiver withArguments: (self mergeArguments: anArray)