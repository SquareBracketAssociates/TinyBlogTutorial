*grease-gemstone-core
truncate: anInteger ellipsis: aString
	"Truncate the receiver to anInteger characters and append aString as ellipsis if necessary."

	^ anInteger < self size
		ifTrue: [ (self copyFrom: 1 to: anInteger) , aString ]
		ifFalse: [ self copy ]