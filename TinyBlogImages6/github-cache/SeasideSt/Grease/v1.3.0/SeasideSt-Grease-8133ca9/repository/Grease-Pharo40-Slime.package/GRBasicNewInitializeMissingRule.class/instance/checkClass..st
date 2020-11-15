running
checkClass: aContext 
	(aContext isMeta not
		and: [ (aContext includesSelector: #initialize)
		and: [ (#(GRObject GRNotification GRNotification GRError RBLintRule RBTransformationRule) noneSatisfy: [ :each |
				aContext includesBehavior: (Smalltalk globals at: each) ])
		and: [ aContext class methodDictionary noneSatisfy: [ :each | 
				matcher 
					executeTree: each parseTree
					initialAnswer: false ] ] ] ]) ifTrue: [
		result 
			addClass: aContext
			selector: #initialize ]