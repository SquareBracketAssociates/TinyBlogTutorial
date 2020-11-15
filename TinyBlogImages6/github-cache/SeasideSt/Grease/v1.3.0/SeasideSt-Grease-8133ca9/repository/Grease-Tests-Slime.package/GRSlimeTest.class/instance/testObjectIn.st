tests-transform
testObjectIn
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	self compile: 'objectIn1 1 in: [ :val | val factorial ]' in: class.
	self compile: 'objectIn2 2 in: [ :val | | temps | val factorial ]' in: class.
	self compile: 'objectIn3 2 in: [ ''not this'' ]' in: class.
	self 
		runTransformation: GRObjectInRule
		changes: #(
			'objectIn1 [ :val | val factorial ] value: 1'
			'objectIn2 [ :val | | temps | val factorial ] value: 2')