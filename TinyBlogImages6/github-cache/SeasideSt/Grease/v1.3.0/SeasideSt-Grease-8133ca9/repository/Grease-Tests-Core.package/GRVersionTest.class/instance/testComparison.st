tests
testComparison
	self assert: #(1) sortsBefore: #(2).
	self assert: #(2) sortsBefore: #(10).
	self assert: #(1) sortsBefore: #(1 1).
	self assert: #(1 nil nil #alpha) sortsBefore: #(1).
	self assert: #(1 nil nil #alpha) sortsBefore: #(1 0).
	self assert: #(1 nil nil #alpha) sortsBefore: #(1 0 0).
	self assert: #(1 0) sortsBefore: #(2).
	self assert: #(1 0) sortsBefore: #(2 0).
	self assert: #(1 0) sortsBefore: #(1 1).
	self assert: #(1 2) sortsBefore: #(1 10).
	self assert: #(1 0 nil #alpha) sortsBefore: #(1 0).
	self assert: #(1 0 nil #alpha) sortsBefore: #(1 0 0).
	self assert: #(1 0 0) sortsBefore: #(2).
	self assert: #(1 0 0) sortsBefore: #(1 1).
	self assert: #(1 0 1) sortsBefore: #(1 1).
	self assert: #(1 0 1 #alpha) sortsBefore: #(1 1).
	self assert: #(1 1 0 #alpha) sortsBefore: #(1 1).
	self assert: #(1 1 0 #alpha 2) sortsBefore: #(1 1).
	self assert: #(1 1 0 #beta) sortsBefore: #(1 1).
	self assert: #(1 1 0 #beta 2) sortsBefore: #(1 1).
	self assert: #(1 nil nil #alpha) sortsBefore: #(1 nil nil #alpha 2).
	self assert: #(1 nil nil #beta) sortsBefore: #(1 nil nil #beta 2).
	self assert: #(1 0 nil #alpha) sortsBefore: #(1 0 nil #alpha 2).
	self assert: #(1 0 nil #beta) sortsBefore: #(1 0 nil #beta 2).
	self assert: #(1 0 0 #alpha) sortsBefore: #(1 0 0 #alpha 2).
	self assert: #(1 0 0 #beta) sortsBefore: #(1 0 0 #beta 2)