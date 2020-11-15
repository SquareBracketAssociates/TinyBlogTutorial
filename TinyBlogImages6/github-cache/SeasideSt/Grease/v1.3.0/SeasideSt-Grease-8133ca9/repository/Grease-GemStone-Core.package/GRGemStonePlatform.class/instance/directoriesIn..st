file-library
directoriesIn: aPathString
	"Answer a collection of absolute paths for all the directories (no files) in the directory given by aPathString
	must not include directory names that start with ."
	| directory |
	directory := ServerFileDirectory on: aPathString.
	^(directory directoryNames
		reject: [ :each | each first = $. ])
		collect: [ :each | directory fullNameFor: each ]