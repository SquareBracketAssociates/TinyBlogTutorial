file library
filesIn: aPathString
	"Return a collection of absolute paths for all the files (no directories) in the directory given by aPathString
	must not include file names that start with ."
	^ Array streamContents: [ :stream | 
		FileSystem disk filesAt: aPathString do: [ :each |
			each basename first = $. ifFalse: [
				stream nextPut: each asFileReference fullName  ] ] ]