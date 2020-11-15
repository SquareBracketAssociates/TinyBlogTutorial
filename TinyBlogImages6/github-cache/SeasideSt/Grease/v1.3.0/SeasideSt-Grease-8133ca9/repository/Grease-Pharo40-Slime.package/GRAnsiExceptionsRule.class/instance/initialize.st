initialization
initialize
	super initialize.
	self rewriteRule
		replace: '``@block on: `class do: [ | `@temps | ``@.body ]'
			with: '``@block on: `class do: [ :err | | `@temps | ``@.body ]'