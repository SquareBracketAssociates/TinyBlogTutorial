testing
supportsEncoding: aString
	"Answer whether the the given encoding name is supported."

	^ #( 'utf-8' 'UTF-8' 'utf8' 'UTF8' ) includes: aString