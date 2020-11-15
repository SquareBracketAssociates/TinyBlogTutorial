*grease-core
excerpt: aString
	"Answer an excerpt of the receiver that matches the first occurence of aString. If aString isn't found, nil is answered."
	
	^ self excerpt: aString radius: 100