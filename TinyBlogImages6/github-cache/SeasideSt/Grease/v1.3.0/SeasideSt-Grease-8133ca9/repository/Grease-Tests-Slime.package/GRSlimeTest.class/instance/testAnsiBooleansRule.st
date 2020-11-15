tests-transform
testAnsiBooleansRule
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	self compile: 'and 1 and: [ 2 ] and: [ 3 ] and: [ 4 ]' in: class.
	self compile: 'or 1 or: [ 2 ] or: [ 3 ] or: [ 4 ]' in: class.
	self 
		runTransformation: GRAnsiBooleansRule
		changes: #(
			'and 1 and: [ 2 and: [ 3 and: [ 4 ] ] ]'
			'or 1 or: [ 2 or: [ 3 or: [ 4 ] ] ]' )