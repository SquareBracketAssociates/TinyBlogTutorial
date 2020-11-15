running
checkMethod: aContext
	| matches |
	matches := matcher
		executeTree: aContext parseTree
		initialAnswer: OrderedCollection new.
	matches do: [ :node |
		" This ensures that the description is of the form ClassName>>#selector:"
		(node arguments first isLiteralNode
			and: [ node arguments first value isString
			and: [ aContext methodClass name greaseString , '>>#' , aContext selector greaseString ~= node arguments first value ] ]) ifTrue: [
				result addClass: aContext methodClass selector: aContext selector.
				result addSearchString: node arguments first value ].
		" This ensures that the description is a string and ends with a dot."
		(node arguments size > 1
			and: [ node arguments second isLiteralNode
			and: [ node arguments second value isString
			and: [ (node arguments second value endsWithSubCollection: '.') not ] ] ]) ifTrue: [
				result addClass: aContext methodClass selector: aContext selector.
				result addSearchString: node arguments second value ] ]