*grease-tests-gemstone-core
greaseTestsGemStoneCore

	^ self new
		name: 'Grease-Tests-GemStone-Core';
		addDependency: 'Grease-GemStone-Core';
		addDependency: 'Grease-Tests-Core';
		url: #gemstoneUrl;
		yourself