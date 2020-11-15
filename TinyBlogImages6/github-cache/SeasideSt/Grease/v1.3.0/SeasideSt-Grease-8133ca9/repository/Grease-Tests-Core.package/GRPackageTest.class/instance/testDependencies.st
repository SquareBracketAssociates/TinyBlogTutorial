tests-dependencies
testDependencies
	self assert: package dependencies isEmpty.
	package addDependency: 'Lust'.
	package addDependency: 'Envy'.
	self assert: package dependencies size = 2.
	self assert: package dependencies first = 'Lust'.
	self assert: package dependencies last = 'Envy'
	