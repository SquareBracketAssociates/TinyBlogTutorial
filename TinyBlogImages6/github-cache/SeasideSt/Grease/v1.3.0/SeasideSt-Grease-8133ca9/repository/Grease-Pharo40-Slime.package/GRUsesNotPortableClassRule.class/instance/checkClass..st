running
checkClass: aContext 
	aContext allSuperclassesDo: [ :each |
		(self classNames includes: each name) ifTrue: [
			result addClass: aContext.
			result addSearchString: each name ] ]