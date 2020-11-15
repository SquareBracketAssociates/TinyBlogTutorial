running-checks
runTransformation: aClass changes: aCollection
	| expected |
	expected := aCollection 
		collect: [ :each | RBParser parseMethod: each ].
	self run: aClass ignoring: Array new do: [ :rule :rules |
		rule changes do: [ :change |
			self
				assert: (expected anySatisfy: [ :parseTree | change parseTree = parseTree ])
				description: change selector , ' should not be transformed' ].
		expected do: [ :parseTree |
			self
				assert: (rule changes anySatisfy: [ :change | change parseTree = parseTree ])
				description: parseTree selector , ' should be transformed' ] ]