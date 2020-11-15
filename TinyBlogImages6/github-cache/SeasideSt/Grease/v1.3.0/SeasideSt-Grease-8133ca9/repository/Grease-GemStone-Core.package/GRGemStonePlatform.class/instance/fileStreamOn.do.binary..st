file-library
fileStreamOn: aString do: aBlock binary: aBoolean
	| stream dir file |
	[
	file := GsFile openReadOnServer: aString.
		[stream := RWBinaryOrTextStream on: file contents.
		aBoolean 
			ifTrue: [ stream binary ]
			ifFalse: [ stream ascii ]. 
		^ aBlock value: stream ] ensure: [ stream close ]] ensure: [ file close ].