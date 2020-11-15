adding
addAll: aDictionary
	aDictionary keysAndValuesDo: [ :key :value | self at: key put: value ].
	^ aDictionary