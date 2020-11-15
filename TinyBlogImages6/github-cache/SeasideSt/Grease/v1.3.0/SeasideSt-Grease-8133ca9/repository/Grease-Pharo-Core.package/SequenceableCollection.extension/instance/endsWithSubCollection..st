*grease-pharo-core
endsWithSubCollection: aSequenceableCollection
	"Some platforms implement #endsWith: to answer true for an empty argument."
	^ self endsWith: aSequenceableCollection