I represent a dynamic variable i.e., a variable that is
1. process local, that
2. is defined for a given block and that
3. can be nested.

For example:

GRDynamicVariable
	use: 1
	during: [
		self assert: GRDynamicVariable value = 1.
		GRDynamicVariable
			use: 2
			during: [ self assert: GRDynamicVariable value = 2 ].
		self assert: GRDynamicVariable value = 1 ].