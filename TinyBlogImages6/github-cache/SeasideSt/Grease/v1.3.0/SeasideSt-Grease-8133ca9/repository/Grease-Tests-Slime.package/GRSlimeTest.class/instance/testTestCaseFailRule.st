tests-transform
testTestCaseFailRule
	| class |
	class := self
		defineClass: #GRSlimeMockObjectTest
		superclass: #TestCase.
	self compile: 'testMethod self fail' in: class.
	self 
		runTransformation: GRTestAssertionsRule
		changes: #(
			'testMethod self assert: false' )