running
checkMethod: aContext 
	(aContext methodClass isMeta not 
		and: [ (aContext selector beginsWithSubCollection: #initialize) 
		and: [ aContext selector numArgs > 0
		and: [ aContext methodClass ~= GRObject
		and: [ (aContext methodClass includesBehavior: GRObject)
		and: [ (aContext superMessages includes: aContext selector) not 
		and: [ aContext selfMessages noneSatisfy: [ :each | each beginsWithSubCollection: #initialize ] ] ] ] ] ] ]) 
			ifTrue: [ result addClass: aContext methodClass selector: aContext selector ]