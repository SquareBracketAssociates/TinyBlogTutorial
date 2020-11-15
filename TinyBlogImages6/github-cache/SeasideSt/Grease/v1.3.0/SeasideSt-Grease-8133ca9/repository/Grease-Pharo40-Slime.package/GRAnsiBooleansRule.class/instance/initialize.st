initialization
initialize
	super initialize.
	self rewriteRule
		replace: '``@expr1 and: [ | `@temp2 | ``@expr2 ] and: [ | `@temp3 | ``@expr3 ]'
			with: '``@expr1 and: [ | `@temp2 | ``@expr2 and: [ | `@temp3 | ``@expr3 ] ]';
		replace: '``@expr1 and: [ | `@temp2 | ``@expr2 ] and: [ | `@temp3 | ``@expr3 ] and: [ | `@temp4 | ``@expr4 ]'
			with: '``@expr1 and: [ | `@temp2 | ``@expr2 and: [ | `@temp3 | ``@expr3 and: [ | `@temp4 | ``@expr4 ] ] ]';
		replace: '``@expr1 and: [ | `@temp2 | ``@expr2 ] and: [ | `@temp3 | ``@expr3 ] and: [ | `@temp4 | ``@expr4 ] and: [  | `@temp5 | ``@expr5 ]'
			with: '``@expr1 and: [ | `@temp2 | ``@expr2 and: [ | `@temp3 | ``@expr3 and: [ | `@temp4 | ``@expr4 and: [ | `@temp5 | ``@expr5 ] ] ] ]';
		replace: '``@expr1 or: [ | `@temp2 | ``@expr2 ] or: [ | `@temp3 | ``@expr3 ]'
			with: '``@expr1 or: [ | `@temp2 | ``@expr2 or: [ | `@temp3 | ``@expr3 ] ]';
		replace: '``@expr1 or: [ | `@temp2 | ``@expr2 ] or: [ | `@temp3 | ``@expr3 ] or: [ | `@temp4 | ``@expr4 ]'
			with: '``@expr1 or: [ | `@temp2 | ``@expr2 or: [ | `@temp3 | ``@expr3 or: [ | `@temp4 | ``@expr4 ] ] ]';
		replace: '``@expr1 or: [ | `@temp2 | ``@expr2 ] or: [ | `@temp3 | ``@expr3 ] or: [ | `@temp4 | ``@expr4 ] or: [ | `@temp5 | ``@expr5 ]'
			with: '``@expr1 or: [ | `@temp2 | ``@expr2 or: [ | `@temp3 | ``@expr3 or: [ | `@temp4 | ``@expr4 or: [ | `@temp5 | ``@expr5 ] ] ] ]';
		replace: '``@expr1 or: [ | `@temp2 | ``@expr2 ] or: [ | `@temp3 | ``@expr3 ] or: [ | `@temp4 | ``@expr4 ] or: [ | `@temp5 | ``@expr5 ] or: [ | `@temp6 | ``@expr6 ]'
			with: '``@expr1 or: [ | `@temp2 | ``@expr2 or: [ | `@temp3 | ``@expr3 or: [ | `@temp4 | ``@expr4 or: [ | `@temp5 | ``@expr5 or: [ | `@temp6 | ``@expr6 ] ] ] ] ]'