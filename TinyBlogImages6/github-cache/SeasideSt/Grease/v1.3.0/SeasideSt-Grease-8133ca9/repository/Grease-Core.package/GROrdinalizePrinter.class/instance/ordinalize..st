private
ordinalize: anInteger
	^ (anInteger \\ 100 between: 11 and: 13)
		ifTrue: [ 'th' ]
		ifFalse: [ 
			#('st' 'nd' 'rd')
				at: anInteger \\ 10 
				ifAbsent: [ 'th' ] ]