initialization
initialize
	super initialize.
	matcher := RBParseTreeSearcher new.
	matcher 
		matchesAnyOf: #(
			'``@receiver greaseDeprecatedApi: ``@arg1'
			'``@receiver greaseDeprecatedApi: ``@arg1 details: ``@arg2' )
		do: [ :node :answer | answer add: node; yourself ]