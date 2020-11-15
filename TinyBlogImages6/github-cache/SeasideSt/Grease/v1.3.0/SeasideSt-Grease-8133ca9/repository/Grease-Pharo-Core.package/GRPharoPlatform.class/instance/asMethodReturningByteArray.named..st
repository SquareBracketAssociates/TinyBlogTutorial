file library
asMethodReturningByteArray: aByteArrayOrString named: aSymbol
	"Generates the source of a method named aSymbol that returns aByteArrayOrString as a ByteArray"
	^ self useByteArrayLiterals
		ifTrue: [ self asMethodReturningByteArrayLiteral: aByteArrayOrString named: aSymbol ]
		ifFalse: [ self asMethodReturningByteArrayWithCache: aByteArrayOrString named: aSymbol ]