initialization
initialize
	super initialize.
	self rewriteRule
		replace: 'self fail'
			with: 'self assert: false'