*Grease-Pharo40-Slime
greaseSlime
	^ self new
		name: 'Grease-Pharo40-Slime';
		description: 'Code critis for Grease. Detects common types of bugs and non-portable code.';
		addDependency: 'Grease-Core';
		url: #seasideUrl;
		yourself