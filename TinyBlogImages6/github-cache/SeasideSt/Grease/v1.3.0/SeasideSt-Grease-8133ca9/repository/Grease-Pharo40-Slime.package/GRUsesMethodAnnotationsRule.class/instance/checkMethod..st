running
checkMethod: aContext
	(self shouldExclude: aContext) ifFalse: [
		aContext pragmas do: [ :each |
			result 
				addClass: aContext methodClass
				selector: aContext selector.
			result addSearchString: each keyword ] ]