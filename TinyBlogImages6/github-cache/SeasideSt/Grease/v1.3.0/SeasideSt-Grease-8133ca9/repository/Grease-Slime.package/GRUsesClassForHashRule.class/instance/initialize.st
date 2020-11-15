initialization
initialize
	super initialize.
	self matcher
		matches: '`@receiver class hash'
		do: [ :node :answer | answer isNil ifTrue: [ node ] ifFalse: [ answer ] ]