public
nextInt: anInteger
	"Answer a random integer in the interval [1, anInteger]"
	^self mutex critical: [
		self generator nextInt: anInteger ]