tests-block
testEmptyStatements
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	self compile: 'emptyStatement1. self and' in: class.
	self compile: 'emptyStatement2 self and..' in: class.
	self compile: 'emptyStatement3 self and."foo".' in: class.
	self compile: 'emptyStatement4 self and."foo".self and' in: class.
	self 
		runRule: GREmptyStatementsRule
		selectors: #(emptyStatement1 emptyStatement2 emptyStatement3 emptyStatement4)
		ignoring: (Array with: GRUnnecessaryLastPeriodRule)