baseline
slimeForSqueakPharo1xPharo2x: spec
	spec
		project: 'Refactoring-Core'
		with: [ 
			spec
				className: 'ConfigurationOfRefactoringBrowser';
				versionString: #stable;
				loads: #('Core');
				repository: 'http://www.squeaksource.com/MetacelloRepository' ].
	spec
		package: 'Grease-Slime' with: [ spec requires: #('Refactoring-Core' 'Grease-Core') ];
		package: 'Grease-Tests-Slime' with: [ spec requires: #('Grease-Slime') ].
	^ spec
		group: 'Slime' with: #('Grease-Slime');
		group: 'Slime Tests' with: #('Grease-Tests-Slime')