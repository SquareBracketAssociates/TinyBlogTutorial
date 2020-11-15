private
onExceptionReturn: anObject
	[ GRError signal ]
		on: GRError
		do: [ :ex | ^ anObject ].
	
	^ self