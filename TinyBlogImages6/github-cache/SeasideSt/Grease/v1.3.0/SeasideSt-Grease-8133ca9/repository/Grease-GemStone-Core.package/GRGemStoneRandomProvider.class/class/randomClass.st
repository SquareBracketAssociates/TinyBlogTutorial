private
randomClass
	"Answers the random number generator to be used to create session and continuation keys. 
	It will not be seeded, just #new will be sent. So wrap it if you need seeding.
	
	Used by Gemstone/S traditional Randoms which cannot be persisted.
	Used by GemStone to use a secure random when avaiable."
	
	^Smalltalk
		at: #TransientRandom
		ifAbsent: [ 
			Smalltalk 
				at: #HostRandom
				ifAbsent: [ Random ]]