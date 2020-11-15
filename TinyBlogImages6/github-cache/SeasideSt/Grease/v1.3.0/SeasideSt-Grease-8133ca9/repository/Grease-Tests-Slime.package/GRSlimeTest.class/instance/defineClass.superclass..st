accessing-code
defineClass: aClassSymbol superclass: aSuperSymbol
	| class |
	model defineClass: aSuperSymbol , ' subclass: #' , aClassSymbol , '
		instanceVariableNames: '''' 
		classVariableNames: ''''
		poolDictionaries: ''''
		category: ''' , self category , ''''.
	class := model classNamed: aClassSymbol.
	environment 
		addClass: class;
		addClass: class theMetaClass.
	^ class