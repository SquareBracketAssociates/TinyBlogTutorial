instance creation
receiver: anObject selector: aSymbol arguments: anArray 
	^ self basicNew 
		initializeWithReceiver: anObject
			message: (GRBoundMessage selector: aSymbol arguments: anArray);
		yourself