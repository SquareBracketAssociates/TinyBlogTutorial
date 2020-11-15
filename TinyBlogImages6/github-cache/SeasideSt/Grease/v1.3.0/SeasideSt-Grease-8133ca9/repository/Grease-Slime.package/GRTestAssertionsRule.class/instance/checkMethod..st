running
checkMethod: aContext 
	aContext selectedClass isMeta
		ifTrue: [ ^ self ].
	(aContext includesBehaviorNamed: #TestCase)
		ifFalse: [ ^ self ].
	^ super checkMethod: aContext 