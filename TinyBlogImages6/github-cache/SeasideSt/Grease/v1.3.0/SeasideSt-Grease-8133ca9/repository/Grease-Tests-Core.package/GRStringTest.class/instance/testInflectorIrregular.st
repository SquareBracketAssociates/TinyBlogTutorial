tests-pluralize
testInflectorIrregular
	self assert: 'genie' pluralize = 'genies'.
	self assert: 'ox' pluralize = 'oxen'.
	self assert: 'cow' pluralize = 'kine'.
	self assert: 'child' pluralize = 'children'.
	self assert: 'woman' pluralize = 'women'