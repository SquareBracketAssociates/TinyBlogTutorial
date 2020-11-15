initialization
initialize
	super initialize.
	matcher := RBParseTreeSearcher new.
	matcher 
		matches: 'self basicNew initialize'
		do: [ :node :answer | true ]