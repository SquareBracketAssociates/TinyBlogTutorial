tests
testEquality
	self assert: #(1) equals: #(1).
	self assert: #(1) equals: #(1 0).
	self assert: #(1) equals: #(1 0 0).
	self assert: #(1 0) equals: #(1 0).
	self assert: #(1 0) equals: #(1 0 0).
	self assert: #(1 0 0) equals: #(1 0 0).
	self assert: #(1 0 0 #alpha) equals: #(1 0 0 #alpha 1).
	self assert: #(1 0 0 #beta) equals: #(1 0 0 #beta 1)