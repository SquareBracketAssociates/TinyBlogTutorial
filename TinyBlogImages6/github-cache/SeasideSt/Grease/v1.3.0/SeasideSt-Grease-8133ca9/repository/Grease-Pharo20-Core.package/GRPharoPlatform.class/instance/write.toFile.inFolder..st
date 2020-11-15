file library
write: aStringOrByteArray toFile: aFileNameString inFolder: aFolderString
	"writes aStringOrByteArray to a file named aFilenameString in the folder aFolderString"
	| folder stream fullFilePath |
	folder := FileSystem disk resolveString: aFolderString.
	fullFilePath := (folder / aFileNameString) asFileReference.
	stream := aStringOrByteArray isString
		ifTrue: [
			(MultiByteFileStream forceNewFileNamed: fullFilePath fullName)
				ascii;
				wantsLineEndConversion: true;
				yourself ]
		ifFalse: [ (FileStream forceNewFileNamed: fullFilePath fullName) binary ].
	[ stream nextPutAll: aStringOrByteArray ]
		ensure: [ stream close ]