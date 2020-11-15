running
checkMethod: aContext 
	(aContext selectedClass theNonMetaClass category indexOfSubCollection: #'-Pharo-' startingAt: 1) ~= 0 ifTrue: [
		"classes in a -Pharo- package are per definition not portable and therefore allowed to use non-portable classes"
		^ self ].
	aContext compiledMethod literals do: [ :each | 
		(each isVariableBinding and: [ self classNames includes: each key ]) ifTrue: [
			result 
				addClass: aContext selectedClass
				selector: aContext selector.
			result addSearchString: each key ] ]