tests
testWithNestedValue
	GRDynamicVariable 
		use: 'outer' 
		during: [
			GRDynamicVariable 
				use: 'inner'
				during: [ self assert: GRDynamicVariable value = 'inner' ].
			self assert: GRDynamicVariable value = 'outer' ]