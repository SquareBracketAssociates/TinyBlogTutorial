adding
addAll: aDictionary
	aDictionary keysAndValuesDo: [ :key :value |
			self privateAt: key put: value ].
	^ aDictionary