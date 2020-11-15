running
checkMethod: aContext
	(self shouldExclude: aContext) ifFalse: [
		aContext compiledMethod pragmas do: [ :each |
			result 
				addClass: aContext selectedClass
				selector: aContext selector.
			result addSearchString: each keyword ] ]