tests-pluralize
testInflectorNotInflecting
	self assert: 'fish' pluralize = 'fish'.
	self assert: 'travois' pluralize = 'travois'.
	self assert: 'chassis' pluralize = 'chassis'.
	self assert: 'nationalities' pluralize = 'nationalities'