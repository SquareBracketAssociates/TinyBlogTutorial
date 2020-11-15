file library
directoriesIn: aPathString
	"Answer a collection of absolute paths for all the directories (no files) in the directory given by aPathString
	must not include directory names that start with ."
	self subclassResponsibility