running
checkMethod: aContext
	| foundLiteral |
	foundLiteral := false.
	"check individual literals first"
	aContext literals do: [ :each | 
		(each isString and: [ each isWideString ]) ifTrue: [
			result 
				addClass: aContext methodClass
				selector: aContext selector.
			result addSearchString:  each.
			foundLiteral := true ] ].
	
	"now check the whole method, could be in comments"
	foundLiteral ifFalse: [
		aContext sourceCode asString isWideString ifTrue: [
			result addClass: aContext methodClass selector: aContext selector ] ]