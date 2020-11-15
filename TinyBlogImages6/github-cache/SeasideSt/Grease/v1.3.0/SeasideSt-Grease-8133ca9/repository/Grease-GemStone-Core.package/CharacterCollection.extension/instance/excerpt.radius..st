*grease-gemstone-core
excerpt: aString radius: anInteger
	"Answer an excerpt of the receiver that matches the first occurence of aString. The radius anInteger expands the excerpt on each side of the first occurrence by the number of characters defined in radius. If aString isn't found, nil is answered."
	
	^ self excerpt: aString radius: anInteger ellipsis: '...'