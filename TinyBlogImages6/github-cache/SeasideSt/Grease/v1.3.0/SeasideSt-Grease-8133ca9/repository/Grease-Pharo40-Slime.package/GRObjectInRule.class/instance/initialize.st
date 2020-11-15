initialization
initialize
	super initialize.
	self rewriteRule
		replace: '``@object in: [ :`var | | `@temps | `@.statements ]'
		with: '[ :`var | | `@temps | `@.statements ] value: ``@object'