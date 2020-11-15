file library
filesIn: aPathString
	"Answer a collection of absolute paths for all the files (no directories) in the directory given by aPathString
	must not include file names that start with ."
	self subclassResponsibility