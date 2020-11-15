initialization
initialize
	super initialize.
	self matcher
		matches: '{ `@.stmts }'
		do: [ :node :answer | answer isNil ifTrue: [ node ] ifFalse: [ answer ] ]