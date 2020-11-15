configuration
createArbitraryAssociations
	^ OrderedCollection new
		add: 'c' -> 3;
		add: 'a' -> 1;
		add: 'b' -> 2;
		add: 'd' -> 1;
		add: 'b' copy -> 4;
		yourself