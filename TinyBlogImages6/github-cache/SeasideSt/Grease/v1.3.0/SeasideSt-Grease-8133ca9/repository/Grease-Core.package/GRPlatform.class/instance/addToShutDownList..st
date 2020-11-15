startup
addToShutDownList: anObject
	"Add anObject to the shutdown-list of the system. On shutdown the message #shutDown will be sent to anObject."
	self subclassResponsibility