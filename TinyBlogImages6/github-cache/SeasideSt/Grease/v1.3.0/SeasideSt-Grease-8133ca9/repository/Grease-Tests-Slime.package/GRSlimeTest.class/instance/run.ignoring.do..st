running-checks
run: aClass ignoring: aCollectionOfClasses do: aBlock
	| rules rule composite undo |
	rules := self rules
		collect: [ :each | each new ].
	rule := rules
		detect: [ :each | each isKindOf: aClass ]
		ifNone: [ self error: aClass name , ' is not a slime rule' ].
	self
		assert: (rule name isString and: [ rule name notEmpty ])
		description: aClass name , ' has no name'.
	self
		assert: (rule rationale isString and: [ rule rationale notEmpty and: [ rule rationale endsWithSubCollection: '.' ] ])
		description: aClass name , ' has no rationale'.
	composite := RBCompositeLintRule rules: rules name: 'Slime'.
	undo := model changes execute.
	[	RBSmalllintChecker runRule: composite onEnvironment: environment.
		rules do: [ :each |
			self 
				assert: (rule = each or: [ (each result isEmpty and: [ each changes isEmpty ]) or: [ aCollectionOfClasses includes: each class ] ])
				description: each name , ' should not report errors' ].
		aBlock value: rule value: rules ]
			ensure: [ undo execute ].
	^ rule