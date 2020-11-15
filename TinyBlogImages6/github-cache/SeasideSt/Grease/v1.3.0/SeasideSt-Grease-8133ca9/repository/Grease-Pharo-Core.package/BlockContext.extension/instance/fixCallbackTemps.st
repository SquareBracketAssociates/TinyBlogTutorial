*grease-pharo-core
fixCallbackTemps
	"Fix the values of the temporary variables used in the block that are
	ordinarily shared with the method in which the block is defined.

	This is needed because Squeak is a crappy Smalltalk implementation
	that does not have full blcck closures."

	| temps |
	home := home copy.
	home swapSender: nil.
	home isMethodContext
		ifFalse: [ ^ self ].
	temps := self tempVarRefs.
	1 to: home size do: [ :index |
		(temps includes: index)
			ifFalse: [ home tempAt: index put: nil ] ]