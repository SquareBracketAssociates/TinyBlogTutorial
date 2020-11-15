instance creation
withAll: aDictionary
	^ (self new: aDictionary size)
		addAll: aDictionary;
		yourself