public
nextInt: anInteger
	"Answer a random integer in the interval [1, anInteger]"

	^ mutex critical: [ generator nextInt: anInteger ]