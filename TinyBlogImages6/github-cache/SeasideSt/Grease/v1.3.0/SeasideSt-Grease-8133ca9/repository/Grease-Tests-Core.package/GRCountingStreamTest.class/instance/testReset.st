testing
testReset
	countingStream nextPut: $a.
	self assert: countingStream count = 1.
	countingStream reset.
	self assert: countingStream count = 0