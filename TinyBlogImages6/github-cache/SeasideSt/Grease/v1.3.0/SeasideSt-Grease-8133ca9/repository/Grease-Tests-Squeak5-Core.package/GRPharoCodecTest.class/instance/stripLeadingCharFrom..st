private
stripLeadingCharFrom: aString 
	"strips the leadingChar from every character in the given string"
	^ String streamContents: [ :stream | 
		aString do: [ :each | 
			stream nextPut: (Character 
				leadingChar: 0
				code: each greaseInteger) ] ]