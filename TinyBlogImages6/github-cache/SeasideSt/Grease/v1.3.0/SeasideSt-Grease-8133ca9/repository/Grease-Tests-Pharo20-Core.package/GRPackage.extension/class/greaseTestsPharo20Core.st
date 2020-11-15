*grease-tests-pharo20-core
greaseTestsPharo20Core
	^ self new
		name: 'Grease-Tests-Pharo20-Core';
		description: 'Unit tests for the package Grease-Pharo-Core.';
		addDependency: 'Grease-Pharo20-Core';
		addDependency: 'Grease-Tests-Core';
		url: #greaseUrl;
		yourself