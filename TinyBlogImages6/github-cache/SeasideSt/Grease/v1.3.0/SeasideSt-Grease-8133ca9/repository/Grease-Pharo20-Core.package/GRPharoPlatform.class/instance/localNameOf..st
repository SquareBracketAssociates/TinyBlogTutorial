file library
localNameOf: aFilename
	^ (FileSystem disk resolveString: aFilename) basename