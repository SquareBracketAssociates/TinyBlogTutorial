tests-transform
testNotPortableCollectionsRule
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	self compile: 'beginsWith1 ''abc'' beginsWith: ''a''' in: class.
	self compile: 'endsWith1 ''abc'' endsWith: ''a''' in: class.
	self 
		runTransformation: GRNotPortableCollectionsRule
		changes: #(
			'beginsWith1 ''abc'' beginsWithSubCollection: ''a'''
			'endsWith1 ''abc'' endsWithSubCollection: ''a''')