startup
addToStartUpList: anObject
	"Add anObject to the startup-list of the system. On startup the message #startUp will be sent to anObject."
	self subclassResponsibility