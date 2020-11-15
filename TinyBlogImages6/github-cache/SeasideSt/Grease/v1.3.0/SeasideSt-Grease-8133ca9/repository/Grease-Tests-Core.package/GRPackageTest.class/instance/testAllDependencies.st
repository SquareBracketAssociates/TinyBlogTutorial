tests-dependencies
testAllDependencies
	| packages |
	packages := Dictionary new.
	packages 
		at: 'Lust' put: (GRPackage new
			name: 'Lust';
			addDependency: 'Gluttony';
			addDependency: 'Greed';
			yourself);
		at: 'Gluttony' put: (GRPackage new
			name: 'Gluttony';
			addDependency: 'Greed';
			yourself);
		at: 'Greed' put: (GRPackage new
			name: 'Greed';
			yourself).
	packages values 
		do: [ :each | each resolveWith: packages ].
	
	self assert: (packages at: 'Lust') allDependencies size = 3.
	self assert: (packages at: 'Gluttony') allDependencies size = 2.
	self assert: (packages at: 'Greed') allDependencies size = 1