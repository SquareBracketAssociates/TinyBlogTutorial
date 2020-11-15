running
checkClass: aContext 
	| comment |
	aContext isMeta 
		ifTrue: [ ^ self ].
	comment := aContext organization classComment asString.
	comment isWideString ifTrue: [
		result addClass: aContext ]