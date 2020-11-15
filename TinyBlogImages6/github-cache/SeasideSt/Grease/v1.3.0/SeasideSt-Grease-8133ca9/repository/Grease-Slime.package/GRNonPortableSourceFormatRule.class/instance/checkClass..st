running
checkClass: aContext 
	| comment |
	aContext selectedClass isMeta 
		ifTrue: [ ^ self ].
	comment := aContext selectedClass organization classComment asString.
	comment isWideString ifTrue: [
		result addClass: aContext selectedClass ]