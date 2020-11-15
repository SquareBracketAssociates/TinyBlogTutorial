running
checkMethod: aContext
	aContext parseTree selector = #hash
		ifTrue: [ super checkMethod: aContext ]