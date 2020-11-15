tests
testNewline
	self assert: GRPlatform current newline isString.
	self deny: GRPlatform current newline isEmpty