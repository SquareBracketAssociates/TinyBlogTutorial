initialization
initialize
	super initialize.
	self rewriteRule
		replace: '`@collection beginsWith: `@subCollection'
			with: '`@collection beginsWithSubCollection: `@subCollection';
		replace: '`@collection endsWith: `@subCollection'
			with: '`@collection endsWithSubCollection: `@subCollection'