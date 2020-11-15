initialization
initialize
	super initialize.
	self matcher
		matches: '^ ``@expr'
		do: [ :node :answer |
			answer isNil 
				ifFalse: [ answer ]
				ifTrue: [ 
					node start + 2 ~= node value start
						ifTrue: [ node ] ] ]