file-library
contentsOfFile: aString binary: aBoolean
	^ self fileStreamOn: aString do: [ :stream | stream contents ] binary: aBoolean