*grease-tests-slime
greaseTestsSlime
	^ self new
		name: 'Grease-Tests-Slime';
		description: 'Unit tests for the package Grease-Slime.';
		addDependency: 'Grease-Slime';
		url: #seasideUrl;
		yourself