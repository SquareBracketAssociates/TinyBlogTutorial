*grease-tests-squeak5-core
greaseTestsSqueak5Core
	^ self new
		name: 'Grease-Tests-Squeak5-Core';
		description: 'Unit tests for the package Grease-Squeak5-Core.';
		addDependency: 'Grease-Squeak5-Core';
		addDependency: 'Grease-Tests-Core';
		url: #seasideUrl;
		yourself