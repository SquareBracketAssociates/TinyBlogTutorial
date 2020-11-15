printing
print: anObject on: aStream 
	| string |
	string := anObject greaseString.
	trim isNil
		ifFalse: [ string := string perform: trim ].
	length isNil ifFalse: [
		length < string size 
			ifTrue: [ string := string copyFrom: 1to: length ].
		(pad isNil or: [ character isNil ])
			ifFalse: [ string := self perform: pad with: string with: character with: length ] ].
	aStream nextPutAll: string