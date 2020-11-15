file-library
ensureExistenceOfFolder: aString
	"creates a folder named aString in the default server directory"
	ServerFileDirectory default assureExistenceOfPath: aString