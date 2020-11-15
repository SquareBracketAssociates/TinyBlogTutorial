tests
testGreaseIntegerOnCharacter
	| character |
	character := Character codePoint: 19982.
	self assert: character greaseInteger = 19982.
	character := Unicode value: 19982.
	self assert: character greaseInteger = 19982.
	LanguageEnvironment allSubclassesDo: [ :each | 
		(each class selectors includes: #leadingChar) ifTrue: [
			"fuck me gently with a chainsaw"
			character := Character 
				leadingChar: each leadingChar
				code: 19982.
			self assert: character greaseInteger = 19982 ] ]