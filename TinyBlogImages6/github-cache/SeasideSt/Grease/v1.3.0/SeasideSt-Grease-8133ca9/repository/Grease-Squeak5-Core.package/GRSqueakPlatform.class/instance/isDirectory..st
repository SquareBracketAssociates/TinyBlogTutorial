file library
isDirectory: aPathString
	^ (FileDirectory forFileName: aPathString) directoryEntry isDirectory