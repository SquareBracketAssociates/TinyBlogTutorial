instance creation
selector: aSymbol arguments: anArray
	^ self basicNew
		initializeWithSelector: aSymbol arguments: anArray;
		yourself