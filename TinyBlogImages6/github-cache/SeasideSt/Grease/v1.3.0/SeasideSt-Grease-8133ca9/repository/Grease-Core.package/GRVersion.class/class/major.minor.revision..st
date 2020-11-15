instance creation
major: majorInteger minor: minorInteger revision: revisionInteger
	^ self basicNew
		initializeWithMajor: majorInteger minor: minorInteger revision: revisionInteger;
		yourself