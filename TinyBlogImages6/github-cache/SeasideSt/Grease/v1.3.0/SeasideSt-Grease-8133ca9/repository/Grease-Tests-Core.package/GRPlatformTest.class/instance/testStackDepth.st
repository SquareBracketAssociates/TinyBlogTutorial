tests
testStackDepth
	| stackDepth someBlock |
	stackDepth := self platform stackDepth.
	self assert: stackDepth isInteger.
	self assert: stackDepth > 0.
	someBlock := [ self assert: self platform stackDepth > stackDepth ].
	someBlock value.
	self assert: stackDepth = self platform stackDepth