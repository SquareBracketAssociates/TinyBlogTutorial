tests
testSignalWithNotificationClassSide
	"Exception class>>signal: is part of the ANSI Smalltalk standard. However, Seaside
	only signals subclasses of GRError and GRNotification so Smalltalk
	implementations that do not otherwise provide it can implement it on
	these two classes."
	| text |
	text := 'Notification'.
	[ GRNotification signal: text ] 
		on: GRNotification
		do: 
			[ :e | 
			self assert: e messageText = text.
			^ self ].
	self assert: false