private
addDependenciesTo: aCollection
	(aCollection includes: self) ifFalse: [
		self dependencies
			do: [ :each | each addDependenciesTo: aCollection ].
		aCollection add: self ].
	^ aCollection