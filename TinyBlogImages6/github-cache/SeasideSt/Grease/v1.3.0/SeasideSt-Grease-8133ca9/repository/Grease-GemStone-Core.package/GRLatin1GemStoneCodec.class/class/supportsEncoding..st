testing
supportsEncoding: aString
	"Answer whether the the given encoding name is supported."

	^ #('iso-8859-1' 'ISO-8859-1' 'latin-1' 'latin1') includes: aString