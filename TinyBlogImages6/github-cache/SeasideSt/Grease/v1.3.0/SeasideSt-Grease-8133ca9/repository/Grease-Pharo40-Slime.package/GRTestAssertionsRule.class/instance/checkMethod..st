running
checkMethod: aContext 
	aContext methodClass isMeta
		ifTrue: [ ^ self ].
	(aContext methodClass allSuperclasses includes:(Smalltalk at: #TestCase))
		ifFalse: [ ^ self ].
	^ super checkMethod: aContext 