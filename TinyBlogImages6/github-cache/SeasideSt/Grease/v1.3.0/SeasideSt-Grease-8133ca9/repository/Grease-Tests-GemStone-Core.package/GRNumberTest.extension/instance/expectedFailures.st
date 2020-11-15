*grease-tests-gemstone-core
expectedFailures
	"GemStone does not conform to the ANSI standard in this case"

	((System stoneVersionAt: 'gsVersion') beginsWith: '2.') ifTrue: [  ^#( #testToDoClosures ) ].
	^#()