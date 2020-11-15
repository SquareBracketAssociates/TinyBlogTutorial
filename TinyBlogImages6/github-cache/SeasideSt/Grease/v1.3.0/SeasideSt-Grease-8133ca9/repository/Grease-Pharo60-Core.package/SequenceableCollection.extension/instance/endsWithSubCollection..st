*Grease-Pharo60-Core
endsWithSubCollection: aSequenceableCollection
	"Some platforms implement #endsWith: to answer true for an empty argument."
	^ self endsWith: aSequenceableCollection