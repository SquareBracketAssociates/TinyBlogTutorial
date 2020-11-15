testing
testAdd
	| object |
	object := Object new.
	self assert: collection size = 0.
	self assert: (collection add: object) == object.
	self assert: collection size = 1.
	self assert: (collection add: object) == object