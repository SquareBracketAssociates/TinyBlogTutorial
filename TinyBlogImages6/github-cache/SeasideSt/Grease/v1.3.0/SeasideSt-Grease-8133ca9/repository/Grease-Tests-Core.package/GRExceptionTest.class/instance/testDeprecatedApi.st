tests
testDeprecatedApi
	| exception seen |
	exception := seen := nil.
	
	[ self 
		greaseDeprecatedApi: 'GRExceptionTest>>#testDeprecatedApi'
		details: 'Message in a bottle.'.
	seen := true ] 
		on: GRDeprecatedApiNotification
		do: 
			[ :notification | 
			exception := notification.
			exception resume.
			seen := false ].
	self assert: seen.
	self assert: exception notNil.
	self assert: exception messageText = 'GRExceptionTest>>#testDeprecatedApi'.
	self assert: exception details = 'Message in a bottle.'