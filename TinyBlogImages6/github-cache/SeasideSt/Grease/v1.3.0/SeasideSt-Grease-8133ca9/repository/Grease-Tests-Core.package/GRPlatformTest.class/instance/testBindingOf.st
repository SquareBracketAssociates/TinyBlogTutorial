tests
testBindingOf
	| binding |
	binding := GRPlatform current bindingOf: GRPlatform.
	self assert: binding value == GRPlatform