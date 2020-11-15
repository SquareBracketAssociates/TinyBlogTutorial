factory
newRandom
	"Answers the random number generator to be used to create session and continuation keys. Make sure it is seeded. They only methods that will be sent to it are:
	  #nextInt: - should answer a random integer in the interval [1, anInteger]
	  #randomFrom: - should answer a random element from the given collection
	
	Make sure that both methods are safe under heavy concurrent load.
	
	Used by Gemstone/S traditional Randoms which cannot be persisted.
	Used by Squeak to use a secure random when avaiable."
	self subclassResponsibility