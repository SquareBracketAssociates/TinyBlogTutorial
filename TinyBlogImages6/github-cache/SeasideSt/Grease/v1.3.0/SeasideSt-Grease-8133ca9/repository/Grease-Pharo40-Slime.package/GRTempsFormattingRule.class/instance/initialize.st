initialization
initialize
	super initialize.
	self matcher
		matches: '| `temp `@temps | ``@.stmts'
		do: [ :node :answer |
			answer isNil 
				ifFalse: [ answer ]
				ifTrue: [ 
					(node leftBar notNil and: [ node rightBar notNil ]) ifTrue: [
						| found position |
						found := false.
						position := node leftBar.
						node temporaries do: [ :each | 
							found := found or: [ position + 2 ~= each start ].
							position := each stop ].
						found := found or: [ position + 2 ~= node rightBar ].
						found ifTrue: [ node ] ] ] ]