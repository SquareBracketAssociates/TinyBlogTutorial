printing
print: anObject
	^ String streamContents: [ :stream | self print: anObject on: stream ]