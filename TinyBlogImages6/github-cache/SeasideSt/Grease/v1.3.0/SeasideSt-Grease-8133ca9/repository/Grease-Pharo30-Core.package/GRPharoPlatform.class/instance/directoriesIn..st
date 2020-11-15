file library
directoriesIn: aPathString
	"Answer a collection of absolute paths for all the directories (no files) in the directory given by aPathString
	must not include directory names that start with ."
	^ Array streamContents: [ :stream | 
		FileSystem disk directoriesAt: aPathString do: [ :each |
			each basename first = $. ifFalse: [
				stream nextPut: each asFileReference fullName  ] ] ]