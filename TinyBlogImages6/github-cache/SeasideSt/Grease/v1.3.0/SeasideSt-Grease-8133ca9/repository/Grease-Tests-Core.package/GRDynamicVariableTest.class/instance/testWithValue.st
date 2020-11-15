tests
testWithValue
	GRDynamicVariable 
		use: 'value' 
		during: [ self assert: GRDynamicVariable value = 'value' ]