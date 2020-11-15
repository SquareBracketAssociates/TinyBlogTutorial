*grease-gemstone-core
beginsWithSubCollection: aSequenceableCollection
	"Some platforms implement #beginsWith: to answer true for an empty argument."
	
	aSequenceableCollection isEmpty ifTrue: [ ^false ].
	^ self beginsWith: aSequenceableCollection