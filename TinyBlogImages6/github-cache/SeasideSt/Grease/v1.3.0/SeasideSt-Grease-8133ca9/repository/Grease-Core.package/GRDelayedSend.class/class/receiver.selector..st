instance creation
receiver: anObject selector: aSymbol 
	^ self basicNew 
		initializeWithReceiver: anObject
			message: (GRUnboundMessage selector: aSymbol);
		yourself