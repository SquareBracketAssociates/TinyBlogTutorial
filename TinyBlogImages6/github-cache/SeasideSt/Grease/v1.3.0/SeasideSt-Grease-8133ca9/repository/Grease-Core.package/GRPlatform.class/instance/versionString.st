version info
versionString
	^ String streamContents: [ :stream |
		stream
			nextPutAll: (self version greaseString);
			nextPutAll: ' (';
			nextPutAll: (self label);
			nextPut: $) ]