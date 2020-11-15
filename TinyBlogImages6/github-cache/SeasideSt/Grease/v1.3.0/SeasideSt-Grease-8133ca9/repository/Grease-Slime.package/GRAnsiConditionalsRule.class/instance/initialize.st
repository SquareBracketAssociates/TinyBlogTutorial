initialization
initialize
	super initialize.
	self rewriteRule
		replace: '``@boolean ifNotNilDo: ``@block'
			with: '``@boolean ifNotNil: ``@block';
		replace: '``@boolean ifNotNilDo: ``@block1 ifNil: ``@block2'
			with: '``@boolean ifNotNil: ``@block1 ifNil: ``@block2';
		replace: '``@boolean ifNil: ``@block1 ifNotNilDo: ``@block2'
			with: '``@boolean ifNil: ``@block1 ifNotNil: ``@block2';
		replace: '``@boolean ifNotNil: [ | `@temps | ``@.body ]'
			with: '``@boolean ifNotNil: [ :arg | | `@temps | ``@.body ]';
		replace: '``@boolean ifNotNil: [ | `@temps | ``@.body ] ifNil: ``@block '
			with: '``@boolean ifNotNil: [ :arg | | `@temps | ``@.body ] ifNil: ``@block';
		replace: '``@boolean ifNil: ``@block ifNotNil: [ | `@temps | ``@.body ]'
			with: '``@boolean ifNil: ``@block ifNotNil: [ :arg | | `@temps | ``@.body ]'