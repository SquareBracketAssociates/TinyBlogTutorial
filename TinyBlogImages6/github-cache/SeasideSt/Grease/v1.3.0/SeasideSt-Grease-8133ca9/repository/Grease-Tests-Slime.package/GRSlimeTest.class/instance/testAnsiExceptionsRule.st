tests-transform
testAnsiExceptionsRule
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	self compile: 'exception1 [ self or ] on: Error do: [ self or ]' in: class.
	self compile: 'exception2 [ self or ] on: Error do: [ self or. self or ]' in: class.
	self compile: 'exception3 [ self or ] on: Error do: [ | a | a := 0 ]' in: class.
	self 
		runTransformation: GRAnsiExceptionsRule
		changes: #( 
			'exception1 [ self or ] on: Error do: [ :err | self or ]'
			'exception2 [ self or ] on: Error do: [ :err | self or. self or ]'
			'exception3 [ self or ] on: Error do: [ :err | | a | a := 0 ]' )