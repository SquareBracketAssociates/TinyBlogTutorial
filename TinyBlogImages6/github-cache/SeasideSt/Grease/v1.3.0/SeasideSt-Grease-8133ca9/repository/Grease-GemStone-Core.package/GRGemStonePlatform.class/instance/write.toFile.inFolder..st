file-library
write: aStringOrByteArray toFile: aFileNameString inFolder: aFolderString
	"writes aStringOrByteArray to a file named aFilenameString in the folder aFolderString"
	| folder stream fullFilePath |
	fullFilePath := ServerFileDirectory default fullNameFor: aFolderString.
	folder := ServerFileDirectory on: fullFilePath.
	stream := folder forceNewFileNamed: aFileNameString.
	stream := aStringOrByteArray isString
		ifTrue: [ stream ascii ]
		ifFalse: [ stream binary ].
	[ stream nextPutAll: aStringOrByteArray ]
		ensure: [ stream close ]