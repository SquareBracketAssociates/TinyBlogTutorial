accessing-code
canParse: aString
	RBParser
		parseMethod: aString
		onError: [ :err :pos | ^ false ].
	^ true