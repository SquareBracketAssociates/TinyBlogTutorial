tests-image
testStartUpList
	"A smoke test: checks if the test-class can be added and removed to the startup list."
	
	[  self platform addToStartUpList: self class ]
		ensure: [  self platform removeFromStartUpList: self class ]