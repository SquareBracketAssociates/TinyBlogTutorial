instance creation
block: aBlock next: aPrinter
	^ self new 
		block: aBlock;
		next: aPrinter;
		yourself