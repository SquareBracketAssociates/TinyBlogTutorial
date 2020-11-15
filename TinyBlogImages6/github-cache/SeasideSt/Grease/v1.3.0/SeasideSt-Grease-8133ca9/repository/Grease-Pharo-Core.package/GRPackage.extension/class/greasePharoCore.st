*grease-pharo-core
greasePharoCore
	^ self new
		name: 'Grease-Pharo-Core';
		addDependency: 'Grease-Core';
		url: #greaseUrl;
		yourself