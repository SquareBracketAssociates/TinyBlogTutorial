adding
at: aKey add: aValue
	"Add an association between aKey and aValue. Do not replace existing
	values with the same key."
	
	^ self privateAt: aKey put: aValue