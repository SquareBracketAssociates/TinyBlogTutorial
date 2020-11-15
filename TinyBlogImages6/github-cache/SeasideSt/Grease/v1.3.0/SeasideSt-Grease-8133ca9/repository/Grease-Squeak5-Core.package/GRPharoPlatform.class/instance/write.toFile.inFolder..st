file library
write: aStringOrByteArray toFile: aFileNameString inFolder: aFolderString
	"writes aStringOrByteArray to a file named aFileNameString in the folder aFolderString"
	| folder stream fullFilePath |
	folder := FileDirectory default directoryNamed: aFolderString.
	fullFilePath := folder fullNameFor: aFileNameString.
	stream := aStringOrByteArray isString
		ifTrue: [		
			(MultiByteFileStream forceNewFileNamed: fullFilePath)
				ascii;
				wantsLineEndConversion: true;
				yourself ]
		ifFalse: [ (FileStream forceNewFileNamed: fullFilePath) binary ].
	[ stream nextPutAll: aStringOrByteArray ]
		ensure: [ stream close ]