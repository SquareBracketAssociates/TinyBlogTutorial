configuration
isValidNewSequencedResponseClass: aClass
	"Answer whether aClass is a valid return type for methods that return a new sequenced
	collection. These are methods such as #copyFrom:to: or #reverse, which are
	defined by ANSI for most classes to return the same class as the receiver.
	However, for Interval (and maybe other cases), ANSI specifies that the response
	may be any <sequencedReadableCollection>."
	
	^ aClass == self collectionClass or: [
		aClass allSuperclasses includes: SequenceableCollection ]