file library
contentsOfFile: aString binary: aBoolean
	| stream |
	stream := aBoolean
		ifTrue: [ (FileDirectory default oldFileNamed: aString)
			binary;
			yourself ]
		ifFalse: [ (MultiByteFileStream oldFileNamed: aString)
			ascii;
			wantsLineEndConversion: true;
			yourself ].
	^ [ stream contents ] ensure: [ stream close ]