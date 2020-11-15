initialization
initialize
	super initialize.
	self matcher
		matches: '[ :`@args | | `@temps | ``@.stmts ]'
		do: [ :node :answer |
			answer isNil 
				ifFalse: [ answer ]
				ifTrue: [
					| source |
					source := node source.
					(source notNil and: [ node left notNil and: [ node right notNil ] ]) ifTrue: [
						| before after |
						before := source at: node left + 1 ifAbsent: [ $ ].
						after := source at: node right - 1 ifAbsent: [ $ ].
						(before isSeparator and: [ after isSeparator ])
							ifFalse: [ node ]
							ifTrue: [
								node bar notNil ifTrue: [ 
									before := source at: node bar - 1 ifAbsent: [ $ ].
									after := source at: node bar + 1 ifAbsent: [ $ ].
									(before isSeparator and: [ after isSeparator ])
										ifFalse: [ node ] ] ] ] ] ]