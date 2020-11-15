running
checkClass: aContext 
	aContext selectedClass allSuperclassesDo: [ :each |
		(self classNames includes: each name) ifTrue: [
			result addClass: aContext selectedClass.
			result addSearchString: each name ] ]