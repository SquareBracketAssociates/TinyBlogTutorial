running
checkClass: aContext 
	(aContext selectedClass isMeta not
		and: [ (aContext selectedClass includesSelector: #initialize)
		and: [ (#(GRObject GRNotification GRNotification GRError RBLintRule RBTransformationRule) noneSatisfy: [ :each |
				aContext selectedClass includesBehavior: (Smalltalk globals at: each) ])
		and: [ aContext selectedClass class methodDictionary noneSatisfy: [ :each | 
				matcher 
					executeTree: each parseTree
					initialAnswer: false ] ] ] ]) ifTrue: [
		result 
			addClass: aContext selectedClass
			selector: #initialize ]