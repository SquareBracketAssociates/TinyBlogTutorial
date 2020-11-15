tests
testSignalWithErrorClassSide
	"Exception class>>signal: is part of the ANSI Smalltalk standard. However, Seaside
	only signals subclasses of GRError and GRNotification so Smalltalk
	implementations that do not otherwise provide it can implement it on
	these two classes."
	| text |
	text := 'Error!'.
	[ GRError signal: text ] 
		on: GRError
		do: 
			[ :e | 
			self assert: e messageText = text.
			^ self ].
	self assert: false