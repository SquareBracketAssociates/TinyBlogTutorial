file library
compile: aString into: aClass classified: aSymbol 
	"The trick here is to be as silently a possible so that the package is not marked dirty when running WAFileLibrary test.
	This also makes running tests much faster."
	| methodNode compiledMethod selector methodAndNode |
	methodNode := aClass compilerClass new 
		compile: aString
		in: aClass
		notifying: nil
		ifFail: [ GRError signal: 'syntax error' ].
	selector := methodNode selector.
	methodAndNode := CompiledMethodWithNode 
		generateMethodFromNode: methodNode
		trailer: aClass defaultMethodTrailer.
	compiledMethod := methodAndNode method.
	compiledMethod 
		putSource: aString
		fromParseNode: methodAndNode node
		inFile: 2
		withPreamble: [ :file | 
			aClass
				printCategoryChunk: aSymbol asString
				on: file priorMethod: (aClass compiledMethodAt: selector ifAbsent: [ nil ]).
			file cr ].
	aClass 
		addSelectorSilently: selector
		withMethod: compiledMethod.
	SystemChangeNotifier uniqueInstance doSilently:  [
		aClass organization 
			classify: selector
			under: aSymbol ]