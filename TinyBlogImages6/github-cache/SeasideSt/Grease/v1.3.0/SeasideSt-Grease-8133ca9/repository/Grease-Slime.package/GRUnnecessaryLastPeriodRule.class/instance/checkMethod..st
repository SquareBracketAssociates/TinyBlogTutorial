running
checkMethod: aContext 
	aContext parseTree nodesDo: [ :node |
		node isSequence ifTrue: [
			(node statements notEmpty and: [ node periods notEmpty ]) ifTrue: [
				node periods last > node statements last stop ifTrue: [
					^ result addClass: aContext selectedClass selector: aContext selector ] ] ] ]