initialization
initialize
	super initialize.
	self matcher
		matchesAnyOf: #(
			'`@receiver canPerform: `@selector'
			'`@receiver canUnderstand: `@selector' )
		do: [ :node :answer | answer isNil ifTrue: [ node ] ifFalse: [ answer ] ]