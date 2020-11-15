tests-image
testShutDownList
	"A smoke test: checks if the test-class can be added and removed to the shutdown list."
	
	[ self platform addToShutDownList: self class ]
		ensure: [  self platform removeFromShutDownList: self class ]