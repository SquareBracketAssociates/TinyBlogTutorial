initialization
initialize
	super initialize.
	self matcher
		matches: '`#literal `{ :node | node isLiteralArray and: [ node isForByteArray ] }'
		do: [ :node :answer | answer isNil ifTrue: [ node ] ifFalse: [ answer ] ]