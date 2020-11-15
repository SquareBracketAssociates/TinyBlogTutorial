tests
testTotalSeconds
	"Answer the total seconds since the Squeak epoch: 1 January 1901."

	| seconds |
	seconds := Time totalSeconds.
	self assert: seconds isInteger.
	self assert: seconds > 3421645167