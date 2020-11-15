testing
supportsEncoding: aString
	^ (#('utf-8' 'UTF-8') includes: aString) or: [ UTF8TextConverter encodingNames includes: aString ]