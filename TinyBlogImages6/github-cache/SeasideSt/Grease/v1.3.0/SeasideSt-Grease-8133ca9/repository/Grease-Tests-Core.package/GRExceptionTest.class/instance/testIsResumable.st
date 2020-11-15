tests
testIsResumable
	"Make sure the platform class provides #isResumable on Exception.
	This test made a bit more complex by James Foster per issue #259
	for GemStone portability."

	| exception |
	[ Exception signal ]
		on: Exception
		do: [ :ex | 
			exception := ex.
			ex return
	].
	self shouldnt: [ exception isResumable ] raise: MessageNotUnderstood