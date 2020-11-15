tests-pluralize
testInflectorCommonSuffixes
	self assert: 'mouse' pluralize = 'mice'.
	self assert: 'synopse' pluralize = 'synopses'.
	self assert: 'man' pluralize = 'men'