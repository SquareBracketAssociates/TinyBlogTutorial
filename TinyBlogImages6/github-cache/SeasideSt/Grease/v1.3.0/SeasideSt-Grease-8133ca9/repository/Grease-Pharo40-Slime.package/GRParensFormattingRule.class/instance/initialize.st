initialization
initialize
	super initialize.
	self matcher
		matches: '`{ :node | node isValue and: [ node hasParentheses ] }'
		do: [ :node :answer |
			answer isNil 
				ifFalse: [ answer ]
				ifTrue: [
					| found start stop |
					found := false.
					start := node startWithoutParentheses.
					stop := node stopWithoutParentheses.
					node parentheses reverseDo: [ :interval |
						found := found
							or: [ start - 1 ~= interval first
							or: [ stop + 1 ~= interval last ] ].
						start := interval first.
						stop := interval last ].
					found ifTrue: [ node ] ] ]