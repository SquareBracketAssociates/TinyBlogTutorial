*grease-gemstone-core
truncate: anInteger
	"Truncate the receiver to anInteger characters."
	
	^ self truncate: anInteger ellipsis: '...'