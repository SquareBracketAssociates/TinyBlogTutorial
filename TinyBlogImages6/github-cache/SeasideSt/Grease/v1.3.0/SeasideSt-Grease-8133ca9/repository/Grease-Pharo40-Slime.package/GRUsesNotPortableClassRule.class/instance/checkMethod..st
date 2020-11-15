running
checkMethod: aContext 
	(aContext methodClass theNonMetaClass category indexOfSubCollection: #'-Pharo-' startingAt: 1) ~= 0 ifTrue: [
		"classes in a -Pharo- package are per definition not portable and therefore allowed to use non-portable classes"
		^ self ].
	aContext literals do: [ :each | 
		(each isVariableBinding and: [ self classNames includes: each key ]) ifTrue: [
			result 
				addClass: aContext methodClass
				selector: aContext selector.
			result addSearchString: each key ] ]