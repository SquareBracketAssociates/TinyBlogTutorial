private
basicPerformFor: receiver withArguments: anArray
	^ anArray size = selector numArgs
		ifTrue: [ receiver perform: selector withArguments: anArray ]
		ifFalse: [ self invalidArgumentCount ]