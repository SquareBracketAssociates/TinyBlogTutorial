*grease-tests-core
greaseTestsCore
	^ self new
		name: 'Grease-Tests-Core';
		description: 'Unit tests for the package Grease-Core.';
		addDependency: 'Grease-Core';
		url: #greaseUrl;
		yourself