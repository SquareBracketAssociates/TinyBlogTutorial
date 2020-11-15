file library
compile: aString into: aClass classified: aSymbol
	"The trick here is to be as silently a possible so that the package is not marked dirty when running WAFileLibrary test.
	This also makes running tests much faster."
	self subclassResponsibility