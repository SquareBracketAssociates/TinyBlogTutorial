tests
testCompileIntoClassified
	| source protocol selectors selector |
	source := 'aMethod
	^ ''a result'''.
	protocol := 'a-protocol'.
	selector := #aMethod.
	GRPlatform current 
		compile: source
		into: self class
		classified: protocol.
	
	[ self assert: (self class selectors includes: selector).
	selectors := self class organization listAtCategoryNamed: protocol.
	self assert: selectors = (Array with: selector) ] ensure: [ self class removeSelectorSilently: selector ]