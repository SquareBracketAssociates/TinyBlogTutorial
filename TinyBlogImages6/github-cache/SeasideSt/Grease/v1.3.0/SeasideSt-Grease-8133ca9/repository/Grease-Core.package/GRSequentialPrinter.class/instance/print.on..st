printing
print: anObject on: aStream 
	parts do: [ :each | each print: anObject on: aStream ]