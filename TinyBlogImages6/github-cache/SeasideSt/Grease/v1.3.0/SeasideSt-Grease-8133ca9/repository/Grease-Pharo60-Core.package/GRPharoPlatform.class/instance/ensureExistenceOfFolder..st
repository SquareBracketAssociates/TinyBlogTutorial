file library
ensureExistenceOfFolder: aString
	"creates a folder named aString in the image directory"
	FileSystem disk ensureCreateDirectory: aString