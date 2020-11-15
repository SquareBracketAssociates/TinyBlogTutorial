initialization
initializeWithName: aString 
	self initialize.
	name := aString.
	urlCodec := (#('iso-8859-15' 'cp-1252') includes: aString) 
		ifFalse: [ GRCodec forEncoding: 'utf-8' ]
		ifTrue: [ self ]