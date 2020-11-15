running
checkClass: aContext
	| selectors |
	selectors := self methodNames
		inject: Set new
		into: [ :set :each | 
			set
				addAll: (aContext whichSelectorsReferTo: each);
				yourself ].
	selectors do: [ :each | result addClass: aContext selector: each ].
	selectors isEmpty
		ifFalse: [ result searchStrings: self methodNames ]