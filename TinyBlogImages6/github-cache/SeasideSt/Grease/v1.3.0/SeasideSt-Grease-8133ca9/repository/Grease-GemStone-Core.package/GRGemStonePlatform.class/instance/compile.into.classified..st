file-library
compile: aString into: aClass classified: aSymbol

	| result |
	result := aClass
		compileMethod: aString
		dictionaries: System myUserProfile symbolList
		category: aSymbol.
	result isNil ifTrue: [^self].
	self error: 'not yet implemented!'.