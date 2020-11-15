printing
print: anObject on: aStream
	anObject = 1
		ifTrue: [ ^ self print: anObject unit: units first on: aStream ].
	units allButFirst
		inject: anObject asFloat
		into: [ :value :each |
			value < base
				ifFalse: [ value / base ]
				ifTrue: [ ^ self print: value unit: each on: aStream ] ]