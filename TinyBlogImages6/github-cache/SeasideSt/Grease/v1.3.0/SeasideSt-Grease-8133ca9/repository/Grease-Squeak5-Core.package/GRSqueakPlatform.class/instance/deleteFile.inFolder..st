file library
deleteFile: aFileName inFolder: aPathString 
	(FileDirectory on: aPathString)
		deleteFileNamed: aFileName